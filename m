Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65768F3F4E
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2019 06:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbfKHFER (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Nov 2019 00:04:17 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43644 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfKHFEQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 00:04:16 -0500
Received: by mail-pl1-f193.google.com with SMTP id a18so3225148plm.10
        for <linux-arch@vger.kernel.org>; Thu, 07 Nov 2019 21:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RbUBT3xfZrIXGoFBBCGxmNcQdirhvysRMETZc4qpbmA=;
        b=ddsbjKc7xWuNdAqUqsG6S0wfScYntbSE7+SC+4OQ/B+DOY4kMUAv+8IUsUwb0fbVJU
         FxxDfYz0eObmt9ssdGv14k98WuInVAJ5Q+UwnA22RQFKJSXNjRFHefSWpkI4f8qeIzXT
         3V6mWTPhxweRYa2erPOFIuy8yoYrcstfZwXEsgLsAiX1Y0BC30NA27TdmjufNgj7wmJg
         Q7R7fdL4YUos0g8CHjjMXjQuLSpZveEZI49SvlX4XyH4N+25Hwp9OSqo011IDncCXuMc
         k8eOfNntGDvQfTt8tifNZ3kJ33n3yePvShyQkSfb8D+33gcl07e54wqPxCtlQQ9rYAJF
         pYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RbUBT3xfZrIXGoFBBCGxmNcQdirhvysRMETZc4qpbmA=;
        b=DpbGoOWl1EGHj+W8rZMcROuXMle3dl/hlaSsdWKIpvFEclppH8MAfs3nUbLCrTyzBm
         HpHbMAuxDtVHaW2ioEOa2qb/u2aZqUEUsVHRmHljS97aCYfW81awvFRe5P8uKidnFdkN
         1RDe4n5ycPzHQzBHwx6yhc3IN0EcMsAIH8dOlqssxcISd907BZzq1SIyenFTRG6/J0UR
         muJON9nYPvcBAx04D1acx4cUsdO1FBjXKCaRS7qE3nE3XDpo+3Ue4F7k6clkl41tVvK5
         ljEie2A5SIAtSiqj3+O1VCchsjs5hFBm2z1pf3IE5L4azTt97rmQ/TBzcJinjq1KlxN/
         9otg==
X-Gm-Message-State: APjAAAV2c422Pw5QRUvNTwwyUpleyr6Ub8Djz9pbjfvE6hHk7596peNj
        7KPjV4ZKoIbBv3fIkyINTbL86y3N3ZY6mQ==
X-Google-Smtp-Source: APXvYqymOj1IbvfHJNXAISqNEVApggDZ/qHVVaWKyywKheNgZ68ExZWrBYK5ApZCxuBsTux6l+DILA==
X-Received: by 2002:a17:902:7207:: with SMTP id ba7mr8327448plb.172.1573189455225;
        Thu, 07 Nov 2019 21:04:15 -0800 (PST)
Received: from earth-mac.local ([202.214.86.179])
        by smtp.gmail.com with ESMTPSA id z23sm4036818pgj.43.2019.11.07.21.04.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 21:04:14 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id A1D7B201ACFE7F; Fri,  8 Nov 2019 14:04:12 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Chenyang Zhong <zhongcy95@gmail.com>,
        Conrad Meyer <cem@FreeBSD.org>,
        Gustavo Bittencourt <gbitten@gmail.com>,
        Motomu Utsumi <motomuman@gmail.com>,
        Patrick Collins <pscollins@google.com>,
        Thomas Liebetraut <thomas@tommie-lie.de>,
        Yuan Liu <liuyuan@google.com>
Subject: [RFC v2 29/37] lkl: add documentation
Date:   Fri,  8 Nov 2019 14:02:44 +0900
Message-Id: <8f62855215a9456512fff52129eebd8f1bb02d63.1573179553.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1573179553.git.thehajime@gmail.com>
References: <cover.1573179553.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Octavian Purdila <tavi.purdila@gmail.com>

A document describing brief introduction of LKL, why it is needed, and
how it is used is added.  The document is located under uml/ directory.

Signed-off-by: Chenyang Zhong <zhongcy95@gmail.com>
Signed-off-by: Conrad Meyer <cem@FreeBSD.org>
Signed-off-by: Gustavo Bittencourt <gbitten@gmail.com>
Signed-off-by: H.K. Jerry Chu <hkchu@google.com>
Signed-off-by: Motomu Utsumi <motomuman@gmail.com>
Signed-off-by: Patrick Collins <pscollins@google.com>
Signed-off-by: Thomas Liebetraut <thomas@tommie-lie.de>
Signed-off-by: Yuan Liu <liuyuan@google.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 Documentation/virt/uml/lkl.txt | 453 +++++++++++++++++++++++++++++++++
 1 file changed, 453 insertions(+)
 create mode 100644 Documentation/virt/uml/lkl.txt

diff --git a/Documentation/virt/uml/lkl.txt b/Documentation/virt/uml/lkl.txt
new file mode 100644
index 000000000000..01c7b8bf7edc
--- /dev/null
+++ b/Documentation/virt/uml/lkl.txt
@@ -0,0 +1,453 @@
+
+Introduction
+============
+
+LKL (Linux Kernel Library) is aiming to allow reusing the Linux kernel code as
+extensively as possible with minimal effort and reduced maintenance overhead.
+
+Examples of how LKL can be used are: creating userspace applications (running on
+Linux and other operating systems) that can read or write Linux filesystems or
+can use the Linux networking stack, creating kernel drivers for other operating
+systems that can read Linux filesystems, bootloaders support for reading/writing
+Linux filesystems, etc.
+
+With LKL, the kernel code is compiled into an object file that can be directly
+linked by applications. The API offered by LKL is based on the Linux system call
+interface.
+
+LKL is implemented as one of the mode of UML (arch/um). It uses host operations
+defined by the application or a host library (tools/lkl/lib).
+
+
+Supported hosts
+===============
+
+The supported hosts for now are POSIX and Windows userspace applications.
+
+
+Building LKL the host library and LKL applications
+==================================================
+
+    $ make -C tools/lkl
+
+will build LKL as a object file, it will install it in tools/lkl/lib together
+with the headers files in tools/lkl/include then will build the host library,
+tests and a few of application examples:
+
+* tests/boot - a simple applications that uses LKL and exercises the basic LKL
+  APIs
+
+* tests/net-test - a simple applications that uses network feature of LKL and
+  exercises the basic network-related APIs
+
+* fs2tar - a tool that converts a filesystem image to a tar archive
+
+* cptofs/cpfromfs - a tool that copies files to/from a filesystem image
+
+* lklfuse - a tool that can mount a filesystem image in userspace,
+  without root privileges, using FUSE
+
+
+Building LKL on FreeBSD
+-----------------------
+
+    $ pkg install binutils gcc gnubc gmake gsed coreutils bison flex python argp-standalone
+
+    #Prefer ports binutils and GNU bc(1):
+    $ export PATH=/sbin:/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/usr/lib64/ccache
+
+    $ gmake -C tools/lkl
+
+Building LKL on Ubuntu
+-----------------------
+
+    $ sudo apt-get install libfuse-dev libarchive-dev xfsprogs
+
+    # Optional, if you would like to be able to run tests
+    $ sudo apt-get install btrfs-tools
+    $ pip install yamlish junit_xml
+
+    $ make -C tools/lkl
+
+    # To check that everything works:
+    $ cd tools/lkl
+    $ make run-tests
+
+
+Building LKL for Windows
+------------------------
+
+In order to build LKL for Win32 the mingw cross compiler needs to be installed
+on the host (e.g. on Ubuntu the following packages are required:
+binutils-mingw-w64-i686, gcc-mingw-w64-base, gcc-mingw-w64-i686
+mingw-w64-common, mingw-w64-i686-dev).
+
+Due to a bug in mingw regarding weak symbols the following patches needs to be
+applied to mingw-binutils:
+
+https://sourceware.org/ml/binutils/2015-10/msg00234.html
+
+and i686-w64-mingw32-gas, i686-w64-mingw32-ld and i686-w64-mingw32-objcopy need
+to be recompiled.
+
+With that pre-requisites fullfilled you can now build LKL for Win32 with the
+following command:
+
+    $ make CROSS_COMPILE=i686-w64-mingw32- -C tools/lkl
+
+
+
+Building LKL on Windows
+------------------------
+
+To build on Windows, certain GNU tools need to be installed. These tools can come
+from several different projects, such as cygwin, unxutils, gnu-win32 or busybox-w32.
+Below is one minimal/modular set-up based on msys2.
+
+### Common build dependencies:
+* [MSYS2](https://sourceforge.net/projects/msys2/) (provides GNU bash and many other utilities)
+* Extra utilities from MSYS2/pacman: bc, base-devel
+
+### General considerations:
+* No spaces in pathnames (source, prefix, destination,...)!
+* Make sure that all utilities are in the PATH.
+* Win64 (and MinGW 64-bit crt) is LLP64, which causes conflicts in size of "long" in the
+Linux source. Linux (and lkl) can (currently) not
+be built on LLP64.
+* Cygwin (and msys2) are LP64, like linux.
+
+### For MSYS2 (and Cygwin):
+Msys2 will install a gcc tool chain as part of the base-devel bundle. Binutils (2.26) is already
+patched for NT weak externals. Using the msys2 shell, cd to the lkl sources and run:
+
+    $ make -C tools/lkl
+
+### For MinGW:
+Install mingw-w64-i686-toolchain via pacman, mingw-w64-i686-binutils (2.26) is already patched
+for NT weak externals. Start a MinGW Win32 shell (64-bit will not work, see above)
+and run:
+
+    $ make -C tools/lkl
+
+
+LKL hijack library
+==================
+
+LKL hijack library (liblkl-hijack.so) is used to replace system calls used by an
+application on the fly so that the application can use LKL instead of the kernel
+of host operating system. LD_PRELOAD is used to dynamically override system
+calls with this library when you execute a program.
+
+You can usually use this library via a wrapper script.
+
+    $ cd tools/lkl
+    $ ./bin/lkl-hijack.sh ip address show
+
+In order to configure the behavior of LKL, a json file can be used. You can
+specify json file with environmental variables (LKL_HIJACK_CONFIG_FILE). If
+there is nothing specified, LKL tries to find with the name 'lkl-hijack.json'
+for the configuration file.  You can also use the old-style configuration with
+environmental variables (e.g., LKL_HIJACK_NET_IFTYPE) but those are overridden
+if a json file is specified.
+
+```
+     $ cat conf.json
+     {
+       "gateway":"192.168.0.1",
+       "gateway6":"2001:db8:0:f101::1",
+       "debug":"1",
+       "singlecpu":"1",
+       "sysctl":"net.ipv4.tcp_wmem=4096 87380 2147483647",
+       "boot_cmdline":"ip=dhcp",
+       "interfaces":[
+               {
+                       "mac":"12:34:56:78:9a:bc",
+                       "type":"tap",
+                       "param":"tap7",
+                       "ip":"192.168.0.2",
+                       "masklen":"24",
+                       "ifgateway":"192.168.0.1",
+                       "ipv6":"2001:db8:0:f101::2",
+                       "masklen6":"64",
+                       "ifgateway6":"2001:db8:0:f101::1",
+                       "offload":"0xc803"
+               },
+               {
+                       "mac":"12:34:56:78:9a:bd",
+                       "type":"tap",
+                       "param":"tap77",
+                       "ip":"192.168.1.2",
+                       "masklen":"24",
+                       "ifgateway":"192.168.1.1",
+                       "ipv6":"2001:db8:0:f102::2",
+                       "masklen6":"64",
+                       "ifgateway6":"2001:db8:0:f102::1",
+                       "offload":"0xc803"
+               }
+       ]
+     }
+     $ LKL_HIJACK_CONFIG_FILE="conf.json" lkl-hijack.sh ip addr s
+```
+
+The following are the list of keys to describe a JSON file.
+
+* IPv4 gateway address
+
+  key: "gateway"
+  value type: string
+
+  the gateway IPv4 address of LKL network stack.
+```
+     "gateway":"192.168.0.1"
+```
+
+* IPv6 gateway address
+
+  key: "gateway6"
+  value type: string
+
+  the gateway IPv6 address of LKL network stack.
+```
+     "gateway6":"2001:db8:0:f101::1"
+```
+
+* Debug
+
+  key: "debug"
+  value type: string
+
+  Setting it causes some debug information (both from the kernel and the
+  LKL library) to be enabled.  If zero' is specified it is disabled.
+  It is also used as a bit mask to turn on specific debugging facilities.
+  E.g., setting it to "0x100" will cause the LKL kernel to pause after
+  the hijack'ed app exits. This allows one to debug or collect info from
+  the LKL kernel before it quits.
+```
+     "debug":"1"
+```
+
+* Single CPU pinning
+
+  key: "singlecpu"
+  value type: string
+
+  Pin LKL kernel threads on to a single host cpu. value "1" pins
+  only LKL kernel threads while value "2" also pins polling
+  threads.
+```
+     "singlecpu":"1"
+```
+
+* SYSCTL
+
+  key: "sysctl"
+  value type: string
+
+  Configure sysctl values of the booted kernel via the hijack library. Multiple
+  entries can be specified.
+```
+     "sysctl":"net.ipv4.tcp_wmem=4096 87380 2147483647"
+```
+
+* Boot command line
+
+  key: "boot_cmdline"
+  value type: string
+
+  Specify the command line to the kernel boot so that change the configuration
+  on a kernel instance.  For instance, you can change the memory size with
+  below.
+```
+     "boot_cmdline": "mem=1G"
+```
+
+* Mount
+
+  key: "mount"
+  value type: string
+
+```
+     "mount": "proc,sysfs"
+```
+
+* Network Interface Configuration
+
+  key: "interfaces"
+  value type: array of objects
+
+  This key takes a set of sub-keys to configure a single interface. Each key is defined as follows.
+  ```
+       "interfaces":[{....},{....}]
+  ```
+
+
+	* Interface type
+
+	  key: "type"
+	  value type: string
+
+	  The interface type in host operating system to connect to LKL.
+	  The following example specifies a tap interface.
+	```
+	     "type":"tap"
+	```
+
+	* Interface parameter
+
+	  key: "param"
+	  value type: string
+
+	  Additional configuration parameters for the interface specified by Interface type (type).
+	  The parameters depend on the interface type.
+	```
+	     "type":"tap",
+	     "param":"tap0"
+	```
+
+	* Interface MTU size
+
+	  key: "mtu"
+	  value type: string
+
+	  the MTU size of the interface.
+	```
+	     "mtu":"1280"
+	```
+
+	* Interface IPv4 address
+
+	  key: "ip"
+	  value type: string
+
+	  the IPv4 address of the interface.
+	  If you want to use DHCP for the IP address assignment,
+	  use "boot_cmdline" with "ip=dhcp" option.
+	```
+	     "ip":"192.168.0.2"
+	```
+	```
+	     "boot_cmdline":"ip=dhcp"
+	```
+
+	* Interface IPv4 netmask length
+
+	  key: "masklen"
+	  value type: string
+
+	  the network mask length of the interface.
+	```
+	     "ip":"192.168.0.2",
+	     "masklen":"24"
+	```
+
+	* Interface IPv4 gateway on routing policy table
+
+	  key: "ifgateway"
+	  value type: string
+
+	  If you specify this parameter, LKL adds routing policy table.
+	  And then LKL creates link local and gateway route on this table.
+	  Table SELECTOR is "from" and PREFIX is address you assigned to this interface.
+	  Table id is 2 * (interface index).
+	  This parameter could be used to configure LKL for mptcp, for example.
+
+	```
+	     "ip":"192.168.0.2",
+	     "masklen":"24",
+	     "ifgateway":"192.168.0.1"
+	```
+
+	* Interface IPv6 address
+
+	  key: "ipv6"
+	  value type: string
+
+	  the IPv6 address of the interface.
+	```
+	     "ipv6":"2001:db8:0:f101::2"
+	```
+
+	* Interface IPv6 netmask length
+
+	  key: "masklen6"
+	  value type: string
+
+	  the network mask length of the interface.
+	```
+	     "ipv6":"2001:db8:0:f101::2",
+	     "masklen":"64"
+	```
+
+	* Interface IPv6 gateway on routing policy table
+
+	  key: "ifgateway6"
+	  value type: string
+
+	  If you specify this parameter, LKL adds routing policy table.
+	  And then LKL creates link local and gateway route on this table.
+	  Table SELECTOR is "from" and PREFIX is address you assigned to this interface.
+	  Table id is 2 * (interface index) + 1.
+	  This parameter could be used to configure LKL for mptcp, for example.
+	```
+	     "ipv6":"2001:db8:0:f101::2",
+	     "masklen":"64"
+	     "ifgateway6":"2001:db8:0:f101::1",
+	```
+
+	* Interface MAC address
+
+	  key: "mac"
+	  value type: string
+
+	  the MAC address of the interface.
+	```
+	     "mac":"12:34:56:78:9a:bc"
+	```
+
+	* Interfac neighbor entries
+
+	  key: "neigh"
+	  value type: string
+
+	  Add a list of permanent neighbor entries in the form of "ip|mac;ip|mac;...". ipv6 are supported
+	```
+	     "neigh":"192.168.0.1|12:34:56:78:9a:bc;2001:db8:0:f101::1|12:34:56:78:9a:be"
+	```
+
+	* Interface qdisc entries
+
+	  key: "qdisc"
+	  value type: string
+
+	  Add a qdisc entry in the form of "root|type;root|type;...".
+	```
+	     "qdisc":"root|fq"
+	```
+
+	* Interface offload
+
+	  key: "offload"
+	  value type: string
+
+	  Work as a bit mask to enable selective device offload features. E.g.,
+	  to enable "mergeable RX buffer" (LKL_VIRTIO_NET_F_MRG_RXBUF) +
+	  "guest csum" (LKL_VIRTIO_NET_F_GUEST_CSUM) device features, simply set
+	  it to 0x8002.
+	  See virtio_net.h for a list of offload features and their bit masks.
+	```
+	     "offload":"0x8002"
+	```
+
+* Delay
+
+  key: "delay_main"
+  value type: string
+
+  The delay before calling main() function of the application after the
+  initialization of LKL.  Some subsystems in Linux tree require a certain
+  amount of time before accepting a request from application, such as
+  delivery of address assignment to an network interface.  This parameter
+  is used in such case.  The value is described as a microsecond value.
+```
+     "delay_main":"500000"
+```
-- 
2.20.1 (Apple Git-117)

