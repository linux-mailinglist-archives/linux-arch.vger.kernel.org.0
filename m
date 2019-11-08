Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91B47F3F47
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2019 06:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfKHFEH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Nov 2019 00:04:07 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39139 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfKHFEH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 00:04:07 -0500
Received: by mail-pl1-f196.google.com with SMTP id o9so3243309plk.6
        for <linux-arch@vger.kernel.org>; Thu, 07 Nov 2019 21:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1QcDUnWZmSajK114RkpJnxazXOd5A5JfEpJcmAK8I0E=;
        b=gS3JlhYApEP9wP0AKJB/PZh+wtKNZktHkWEO6u7NhXNhtB0o8Fy1aQPnCHLG58qa54
         WiDSL2uOBPvqs/y6kDDqHIt8XxY/61Vb63AvBXhPtbLtSDyTmLKQ9UjWZs/CfTDD/x/7
         8DI97DxaxTdp6oQDN3Msh6KgD+med16Oub46fBJh7qOZpPabyakfAByng1bspF147okJ
         S4kNYRyfHN44x3E0pNMbsbweUmezQ0nPjb8RtnMUy4KAJuNWI9jyI1ZH402i6/UWEoct
         EtXfx7X+3EelwxxJbca5WEs9lr50tqtmihVC/hGPIpmPFLvHqeBIi3JUZEsUbJ10fDrg
         42ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1QcDUnWZmSajK114RkpJnxazXOd5A5JfEpJcmAK8I0E=;
        b=RHgrW/hZayxe2mGerRei/nstQ9jGMEkQQ3WcKlCoC+6EUo0dgXYhUux/5ODZ40udTC
         Ms+0od+JV3A/+1XvT3ujpoARoT2jRr9t4RlYQuMumotSPJzlAriFlY3Z3Y1Z9hxbvBNp
         hR1YYuwNp/vqpWEnOmv8Ltahmd/sHVg4RES+ipfp7ZsOmPrtZgSGU8ZoupiEkzLS5Kn/
         ZJzwZeyjz+L7qbDfpA5rrqpaL2kWkysJ7GPvwO+MwGndytgg0L7R+TPnICmaykL5PUYu
         xt9Wf59bWGdQWwZhwHxOQX8Z1cVMOdZDYVYcBqXDzRZYkIMOij89lKcv0CQhv+jr8gob
         KFuA==
X-Gm-Message-State: APjAAAXbs8kwcN6f9TcQbuxNTe5U4EV6J6uqgCnx/FY8YwAzIG/TnKdK
        3BezqCwt6LwxmWv3lViooDQ=
X-Google-Smtp-Source: APXvYqw07O1OkWHTclEgwxc8iXwkKM9jCotJe8/gGfl5op4zTqkKhtYwbJESrD7amMEDfITLvh1t9A==
X-Received: by 2002:a17:90a:ca04:: with SMTP id x4mr10804360pjt.103.1573189444679;
        Thu, 07 Nov 2019 21:04:04 -0800 (PST)
Received: from earth-mac.local ([202.214.86.179])
        by smtp.gmail.com with ESMTPSA id f25sm5352172pfk.10.2019.11.07.21.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 21:04:04 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id 98A94201ACFE1D; Fri,  8 Nov 2019 14:04:02 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Thomas Liebetraut <thomas@tommie-lie.de>
Subject: [RFC v2 26/37] tools: Add the lkl host library to the common tools Makefile
Date:   Fri,  8 Nov 2019 14:02:41 +0900
Message-Id: <80f1531053e8ab8d67ff1995e82f8db75457e0dc.1573179553.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1573179553.git.thehajime@gmail.com>
References: <cover.1573179553.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Thomas Liebetraut <thomas@tommie-lie.de>

This patch includes the lkl host library to the Kernel tools buildsystem.
This also means that lkl can now be compiled like any other "tool" using:

  $ make tools/lkl ARCH=um UMMODE=library

Signed-off-by: Thomas Liebetraut <thomas@tommie-lie.de>
[Octavian: remove make ARCH=lkl defconfig as it is not (yet) necessary]
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 tools/Makefile | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/Makefile b/tools/Makefile
index 68defd7ecf5d..0506d7dde63f 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -23,6 +23,7 @@ help:
 	@echo '  kvm_stat               - top-like utility for displaying kvm statistics'
 	@echo '  leds                   - LEDs  tools'
 	@echo '  liblockdep             - user-space wrapper for kernel locking-validator'
+	@echo '  lkl                    - The Linux Kernel Library host libraries and tools'
 	@echo '  bpf                    - misc BPF tools'
 	@echo '  pci                    - PCI tools'
 	@echo '  perf                   - Linux performance measurement and analysis tool'
@@ -63,7 +64,7 @@ acpi: FORCE
 cpupower: FORCE
 	$(call descend,power/$@)
 
-cgroup firewire hv guest spi usb virtio vm bpf iio gpio objtool leds wmi pci firmware debugging: FORCE
+cgroup firewire hv guest lkl spi usb virtio vm bpf iio gpio objtool leds wmi pci firmware debugging: FORCE
 	$(call descend,$@)
 
 liblockdep: FORCE
@@ -107,7 +108,7 @@ acpi_install:
 cpupower_install:
 	$(call descend,power/$(@:_install=),install)
 
-cgroup_install firewire_install gpio_install hv_install iio_install perf_install spi_install usb_install virtio_install vm_install bpf_install objtool_install wmi_install pci_install debugging_install:
+cgroup_install firewire_install gpio_install hv_install iio_install lkl_install perf_install spi_install usb_install virtio_install vm_install bpf_install objtool_install wmi_install pci_install debugging_install:
 	$(call descend,$(@:_install=),install)
 
 liblockdep_install:
@@ -133,7 +134,7 @@ install: acpi_install cgroup_install cpupower_install gpio_install \
 		perf_install selftests_install turbostat_install usb_install \
 		virtio_install vm_install bpf_install x86_energy_perf_policy_install \
 		tmon_install freefall_install objtool_install kvm_stat_install \
-		wmi_install pci_install debugging_install intel-speed-select_install
+		wmi_install lkl_install pci_install debugging_install intel-speed-select_install
 
 acpi_clean:
 	$(call descend,power/acpi,clean)
@@ -141,7 +142,7 @@ acpi_clean:
 cpupower_clean:
 	$(call descend,power/cpupower,clean)
 
-cgroup_clean hv_clean firewire_clean spi_clean usb_clean virtio_clean vm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean pci_clean firmware_clean debugging_clean:
+cgroup_clean hv_clean firewire_clean lkl_clean spi_clean usb_clean virtio_clean vm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean pci_clean firmware_clean debugging_clean:
 	$(call descend,$(@:_clean=),clean)
 
 liblockdep_clean:
@@ -179,7 +180,7 @@ clean: acpi_clean cgroup_clean cpupower_clean hv_clean firewire_clean \
 		perf_clean selftests_clean turbostat_clean spi_clean usb_clean virtio_clean \
 		vm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
 		freefall_clean build_clean libbpf_clean libsubcmd_clean liblockdep_clean \
-		gpio_clean objtool_clean leds_clean wmi_clean pci_clean firmware_clean debugging_clean \
+		gpio_clean objtool_clean leds_clean wmi_clean lkl_clean pci_clean firmware_clean debugging_clean \
 		intel-speed-select_clean
 
 .PHONY: FORCE
-- 
2.20.1 (Apple Git-117)

