#!/bin/bash

MODULE_ID=${1?Specify a module id}
MODULE_NAME=${2?Specify a module name}


mkdir $MODULE_ID && ( cd $MODULE_ID

##
## Create the pom.xml
##
cat > pom.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!--

    Licensed to the Apache Software Foundation (ASF) under one or more
    contributor license agreements.  See the NOTICE file distributed with
    this work for additional information regarding copyright ownership.
    The ASF licenses this file to You under the Apache License, Version 2.0
    (the "License"); you may not use this file except in compliance with
    the License.  You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
-->


<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>org.superbiz</groupId>
  <artifactId>$MODULE_ID</artifactId>
  <packaging>jar</packaging>
  <version>1.1.1-SNAPSHOT</version>
  <name>Java EE :: Opportunities :: $MODULE_NAME</name>
  <properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
  </properties>
  <build>
    <defaultGoal>install</defaultGoal>
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-compiler-plugin</artifactId>
        <version>3.1</version>
        <configuration>
          <source>1.8</source>
          <target>1.8</target>
        </configuration>
      </plugin>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-surefire-plugin</artifactId>
        <version>2.17</version>
        <configuration>
          <forkMode>pertest</forkMode>
        </configuration>
      </plugin>
    </plugins>
  </build>
  <repositories>
    <repository>
      <id>apache-m2-snapshot</id>
      <name>Apache Snapshot Repository</name>
      <url>http://repository.apache.org/snapshots</url>
    </repository>
  </repositories>
  <dependencies>
    <dependency>
      <groupId>org.apache.openejb</groupId>
      <artifactId>javaee-api</artifactId>
      <version>6.0-6</version>
      <scope>provided</scope>
    </dependency>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.11</version>
      <scope>test</scope>
    </dependency>
    <!--
    The <scope>test</scope> guarantees that non of your runtime
    code is dependent on any OpenEJB classes.
    -->
    <dependency>
      <groupId>org.apache.openejb</groupId>
      <artifactId>openejb-core</artifactId>
      <version>4.7.2-SNAPSHOT</version>
      <scope>test</scope>
    </dependency>
  </dependencies>
  <!--
  This section allows you to configure where to publish libraries for sharing.
  It is not required and may be deleted.  For more information see:
  http://maven.apache.org/plugins/maven-deploy-plugin/
  -->
  <distributionManagement>
    <repository>
      <id>localhost</id>
      <url>file://${basedir}/target/repo/</url>
    </repository>
    <snapshotRepository>
      <id>localhost</id>
      <url>file://${basedir}/target/snapshot-repo/</url>
    </snapshotRepository>
  </distributionManagement>
</project>
EOF
##
##
##

PACKAGE=org.superbiz.${MODULE_ID/-/.}
DIRECTORY=org.superbiz.${MODULE_ID/-//}

##
## Create the main
##
mkdir -p src/main/java/$DIRECTORY &&
cat > src/main/java/$DIRECTORY/Main.java <<EOF
/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */
package $PACKAGE;

public class Main {
}
EOF

##
## Create the test
##
mkdir -p src/test/java/$DIRECTORY &&
cat > src/test/java/$DIRECTORY/MainTest.java <<EOF
/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */
package $PACKAGE;

public class MainTest {
}
EOF

)