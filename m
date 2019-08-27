Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D800B9DE2C
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2019 08:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfH0Gkp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Aug 2019 02:40:45 -0400
Received: from condef-09.nifty.com ([202.248.20.74]:37043 "EHLO
        condef-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfH0Gko (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Aug 2019 02:40:44 -0400
Received: from conuserg-12.nifty.com ([10.126.8.75])by condef-09.nifty.com with ESMTP id x7R6aWsh005504
        for <linux-arch@vger.kernel.org>; Tue, 27 Aug 2019 15:36:32 +0900
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x7R6aHwW018722;
        Tue, 27 Aug 2019 15:36:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x7R6aHwW018722
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566887777;
        bh=5NvDT/q/YL2RvRcc6OUuH/cKpeAgwqpTKx3H7p5QC+o=;
        h=From:To:Cc:Subject:Date:From;
        b=ntsXGczfdyoUDyXu0JeF1Dg6ohbTM0w3jpxJY7u2x9ARnQ5HBz35Hxz1xuynkA6LH
         4jKcVqVVT6k8a67+qKOARyIEDmsJX5FAQC3Yy8xDYBmOMt/Q9PNbxMRJP69hM3fsm9
         HYezJwDaGkpdmFXYaTKv92JNQHqtPyZE+qExLh3pd4pWiktdtBse2Njlc97jJfp7PE
         eMRkCNTsG0/PQpgKQWSvGJOKFzjihW8FFLBS4VCChzsax+blN3iqmotc5UKJZUIZxT
         iXtD3TO4jq0eYKCaM0NMXkPoTqe2U6vtrdFLdPp14WM+Tbitz/3AYw/PBanB4gQgg6
         /UH95HE7Mo3BA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2] kbuild: change *FLAGS_<basetarget>.o to take the path relative to $(obj)
Date:   Tue, 27 Aug 2019 15:36:16 +0900
Message-Id: <20190827063616.18827-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Kbuild provides per-file compiler flag addition/removal:

  CFLAGS_<basetarget>.o
  CFLAGS_REMOVE_<basetarget>.o
  AFLAGS_<basetarget>.o
  AFLAGS_REMOVE_<basetarget>.o
  CPPFLAGS_<basetarget>.lds
  HOSTCFLAGS_<basetarget>.o
  HOSTCXXFLAGS_<basetarget>.o

The <basetarget> is the filename of the target with its directory and
suffix stripped.

This syntax comes into a trouble when two files with the same name
appear in one Makefile, for example:

  obj-y += foo.o
  obj-y += dir/foo.o
  CFLAGS_foo.o := <some-flags>

Here, the <some-flags> applies to both foo.o and dir/foo.o

The real world problem is:

  scripts/kconfig/util.c
  scripts/kconfig/lxdialog/util.c

Both files are compiled into scripts/kconfig/mconf, but only the
latter should be given with additional flags for ncurses.

It is more sensible to use the relative path to the Makefile, like this:

  obj-y += foo.o
  CFLAGS_foo.o := <some-flags>
  obj-y += dir/foo.o
  CFLAGS_dir/foo.o := <other-flags>

The $* variable is replaced with the stem ('%') part in a pattern rule.
In other words, this only works for pattern rules.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Marc Zyngier <maz@kernel.org>
---

Changes in v2:
  - Fix build errors for gpu drivers

 arch/arm/kvm/Makefile                         |  5 ++--
 arch/x86/entry/vdso/Makefile                  |  3 +-
 drivers/gpu/drm/amd/display/dc/calcs/Makefile |  6 ++--
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile |  2 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile   | 17 +++++------
 drivers/gpu/drm/amd/display/dc/dsc/Makefile   |  7 ++---
 drivers/gpu/drm/i915/Makefile                 |  2 +-
 scripts/Makefile.host                         | 30 +++++++++----------
 scripts/Makefile.lib                          | 10 +++----
 scripts/kconfig/Makefile                      |  8 ++---
 10 files changed, 44 insertions(+), 46 deletions(-)

diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
index 531e59f5be9c..b76b75bd9e00 100644
--- a/arch/arm/kvm/Makefile
+++ b/arch/arm/kvm/Makefile
@@ -8,13 +8,14 @@ ifeq ($(plus_virt),+virt)
 	plus_virt_def := -DREQUIRES_VIRT=1
 endif
 
+KVM := ../../../virt/kvm
+
 ccflags-y += -I $(srctree)/$(src) -I $(srctree)/virt/kvm/arm/vgic
-CFLAGS_arm.o := $(plus_virt_def)
+CFLAGS_$(KVM)/arm/arm.o := $(plus_virt_def)
 
 AFLAGS_init.o := -Wa,-march=armv7-a$(plus_virt)
 AFLAGS_interrupts.o := -Wa,-march=armv7-a$(plus_virt)
 
-KVM := ../../../virt/kvm
 kvm-arm-y = $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o $(KVM)/vfio.o
 
 obj-$(CONFIG_KVM_ARM_HOST) += hyp/
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 8df549138193..0f2154106d01 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -89,6 +89,7 @@ $(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS
 #
 CFLAGS_REMOVE_vdso-note.o = -pg
 CFLAGS_REMOVE_vclock_gettime.o = -pg
+CFLAGS_REMOVE_vdso32/vclock_gettime.o = -pg
 CFLAGS_REMOVE_vgetcpu.o = -pg
 CFLAGS_REMOVE_vvar.o = -pg
 
@@ -128,7 +129,7 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
 $(obj)/vdsox32.so.dbg: $(obj)/vdsox32.lds $(vobjx32s) FORCE
 	$(call if_changed,vdso_and_check)
 
-CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
+CPPFLAGS_vdso32/vdso32.lds = $(CPPFLAGS_vdso.lds)
 VDSO_LDFLAGS_vdso32.lds = -m elf_i386 -soname linux-gate.so.1
 
 targets += vdso32/vdso32.lds
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
index 95f332ee3e7e..d930df63772c 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
@@ -32,9 +32,9 @@ endif
 
 calcs_ccflags := -mhard-float -msse $(cc_stack_align)
 
-CFLAGS_dcn_calcs.o := $(calcs_ccflags)
-CFLAGS_dcn_calc_auto.o := $(calcs_ccflags)
-CFLAGS_dcn_calc_math.o := $(calcs_ccflags) -Wno-tautological-compare
+CFLAGS_$(AMDDALPATH)/dc/calcs/dcn_calcs.o := $(calcs_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/calcs/dcn_calc_auto.o := $(calcs_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/calcs/dcn_calc_math.o := $(calcs_ccflags) -Wno-tautological-compare
 
 BW_CALCS = dce_calcs.o bw_fixed.o custom_float.o
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
index e9721a906592..83635ad9124e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
@@ -16,7 +16,7 @@ else ifneq ($(call cc-option, -mstack-alignment=16),)
 	cc_stack_align := -mstack-alignment=16
 endif
 
-CFLAGS_dcn20_resource.o := -mhard-float -msse $(cc_stack_align)
+CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resource.o := -mhard-float -msse $(cc_stack_align)
 
 AMD_DAL_DCN20 = $(addprefix $(AMDDALPATH)/dc/dcn20/,$(DCN20))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 0bb7a20675c4..83792e2c0f0e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -32,19 +32,16 @@ endif
 
 dml_ccflags := -mhard-float -msse $(cc_stack_align)
 
-CFLAGS_display_mode_lib.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
 
 ifdef CONFIG_DRM_AMD_DC_DCN2_0
-CFLAGS_display_mode_vba.o := $(dml_ccflags)
-CFLAGS_display_mode_vba_20.o := $(dml_ccflags)
-CFLAGS_display_rq_dlg_calc_20.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20.o := $(dml_ccflags)
 endif
-ifdef CONFIG_DRM_AMD_DCN3AG
-CFLAGS_display_mode_vba_3ag.o := $(dml_ccflags)
-endif
-CFLAGS_dml1_display_rq_dlg_calc.o := $(dml_ccflags)
-CFLAGS_display_rq_dlg_helpers.o := $(dml_ccflags)
-CFLAGS_dml_common_defs.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/dml_common_defs.o := $(dml_ccflags)
 
 DML = display_mode_lib.o display_rq_dlg_helpers.o dml1_display_rq_dlg_calc.o \
 	dml_common_defs.o
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/Makefile b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
index e019cd9447e8..c3922d6e7696 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
@@ -9,10 +9,9 @@ endif
 
 dsc_ccflags := -mhard-float -msse $(cc_stack_align)
 
-CFLAGS_rc_calc.o := $(dsc_ccflags)
-CFLAGS_rc_calc_dpi.o := $(dsc_ccflags)
-CFLAGS_codec_main_amd.o := $(dsc_ccflags)
-CFLAGS_dc_dsc.o := $(dsc_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dsc/rc_calc.o := $(dsc_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dsc/rc_calc_dpi.o := $(dsc_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dsc/dc_dsc.o := $(dsc_ccflags)
 
 DSC = dc_dsc.o rc_calc.o rc_calc_dpi.o
 
diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index 8cace65f50ce..69c75484cc26 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -26,7 +26,7 @@ subdir-ccflags-$(CONFIG_DRM_I915_WERROR) += -Werror
 
 # Fine grained warnings disable
 CFLAGS_i915_pci.o = $(call cc-disable-warning, override-init)
-CFLAGS_intel_fbdev.o = $(call cc-disable-warning, override-init)
+CFLAGS_display/intel_fbdev.o = $(call cc-disable-warning, override-init)
 
 subdir-ccflags-y += \
 	$(call as-instr,movntdqa (%eax)$(comma)%xmm0,-DCONFIG_AS_MOVNTDQA)
diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index b402c619147d..cd2b98e2f727 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -80,9 +80,9 @@ host-cxxshobjs	:= $(addprefix $(obj)/,$(host-cxxshobjs))
 # Handle options to gcc. Support building with separate output directory
 
 _hostc_flags   = $(KBUILD_HOSTCFLAGS)   $(HOST_EXTRACFLAGS)   \
-                 $(HOSTCFLAGS_$(basetarget).o)
+                 $(HOSTCFLAGS_$*.o)
 _hostcxx_flags = $(KBUILD_HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) \
-                 $(HOSTCXXFLAGS_$(basetarget).o)
+                 $(HOSTCXXFLAGS_$*.o)
 
 # $(objtree)/$(obj) for including generated headers from checkin source files
 ifeq ($(KBUILD_EXTMOD),)
@@ -102,7 +102,7 @@ hostcxx_flags  = -Wp,-MD,$(depfile) $(_hostcxx_flags)
 # host-csingle -> Executable
 quiet_cmd_host-csingle 	= HOSTCC  $@
       cmd_host-csingle	= $(HOSTCC) $(hostc_flags) $(KBUILD_HOSTLDFLAGS) -o $@ $< \
-		$(KBUILD_HOSTLDLIBS) $(HOSTLDLIBS_$(@F))
+		$(KBUILD_HOSTLDLIBS) $(HOSTLDLIBS_$*)
 $(host-csingle): $(obj)/%: $(src)/%.c FORCE
 	$(call if_changed_dep,host-csingle)
 
@@ -110,9 +110,9 @@ $(host-csingle): $(obj)/%: $(src)/%.c FORCE
 # host-cmulti -> executable
 quiet_cmd_host-cmulti	= HOSTLD  $@
       cmd_host-cmulti	= $(HOSTCC) $(KBUILD_HOSTLDFLAGS) -o $@ \
-			  $(addprefix $(obj)/,$($(@F)-objs)) \
-			  $(KBUILD_HOSTLDLIBS) $(HOSTLDLIBS_$(@F))
-$(host-cmulti): FORCE
+			  $(addprefix $(obj)/, $($*-objs)) \
+			  $(KBUILD_HOSTLDLIBS) $(HOSTLDLIBS_$*)
+$(host-cmulti): $(obj)/%: FORCE
 	$(call if_changed,host-cmulti)
 $(call multi_depend, $(host-cmulti), , -objs)
 
@@ -128,9 +128,9 @@ $(host-cobjs): $(obj)/%.o: $(src)/%.c FORCE
 quiet_cmd_host-cxxmulti	= HOSTLD  $@
       cmd_host-cxxmulti	= $(HOSTCXX) $(KBUILD_HOSTLDFLAGS) -o $@ \
 			  $(foreach o,objs cxxobjs,\
-			  $(addprefix $(obj)/,$($(@F)-$(o)))) \
-			  $(KBUILD_HOSTLDLIBS) $(HOSTLDLIBS_$(@F))
-$(host-cxxmulti): FORCE
+			  $(addprefix $(obj)/, $($*-$(o)))) \
+			  $(KBUILD_HOSTLDLIBS) $(HOSTLDLIBS_$*)
+$(host-cxxmulti): $(obj)/%: FORCE
 	$(call if_changed,host-cxxmulti)
 $(call multi_depend, $(host-cxxmulti), , -objs -cxxobjs)
 
@@ -161,9 +161,9 @@ $(host-cxxshobjs): $(obj)/%.o: $(src)/%.c FORCE
 # *.o -> .so shared library (host-cshlib)
 quiet_cmd_host-cshlib	= HOSTLLD -shared $@
       cmd_host-cshlib	= $(HOSTCC) $(KBUILD_HOSTLDFLAGS) -shared -o $@ \
-			  $(addprefix $(obj)/,$($(@F:.so=-objs))) \
-			  $(KBUILD_HOSTLDLIBS) $(HOSTLDLIBS_$(@F))
-$(host-cshlib): FORCE
+			  $(addprefix $(obj)/, $($*-objs)) \
+			  $(KBUILD_HOSTLDLIBS) $(HOSTLDLIBS_$*.so)
+$(host-cshlib): $(obj)/%.so: FORCE
 	$(call if_changed,host-cshlib)
 $(call multi_depend, $(host-cshlib), .so, -objs)
 
@@ -171,9 +171,9 @@ $(call multi_depend, $(host-cshlib), .so, -objs)
 # *.o -> .so shared library (host-cxxshlib)
 quiet_cmd_host-cxxshlib	= HOSTLLD -shared $@
       cmd_host-cxxshlib	= $(HOSTCXX) $(KBUILD_HOSTLDFLAGS) -shared -o $@ \
-			  $(addprefix $(obj)/,$($(@F:.so=-objs))) \
-			  $(KBUILD_HOSTLDLIBS) $(HOSTLDLIBS_$(@F))
-$(host-cxxshlib): FORCE
+			  $(addprefix $(obj)/, $($*-objs)) \
+			  $(KBUILD_HOSTLDLIBS) $(HOSTLDLIBS_$*.so)
+$(host-cxxshlib): $(obj)/%.so: FORCE
 	$(call if_changed,host-cxxshlib)
 $(call multi_depend, $(host-cxxshlib), .so, -objs)
 
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 264611972c4a..0d48e17bfb07 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -109,12 +109,12 @@ basename_flags = -DKBUILD_BASENAME=$(call name-fix,$(basetarget))
 modname_flags  = -DKBUILD_MODNAME=$(call name-fix,$(modname))
 
 orig_c_flags   = $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) \
-                 $(ccflags-y) $(CFLAGS_$(basetarget).o)
-_c_flags       = $(filter-out $(CFLAGS_REMOVE_$(basetarget).o), $(orig_c_flags))
+                 $(ccflags-y) $(CFLAGS_$*.o)
+_c_flags       = $(filter-out $(CFLAGS_REMOVE_$*.o), $(orig_c_flags))
 orig_a_flags   = $(KBUILD_CPPFLAGS) $(KBUILD_AFLAGS) \
-                 $(asflags-y) $(AFLAGS_$(basetarget).o)
-_a_flags       = $(filter-out $(AFLAGS_REMOVE_$(basetarget).o), $(orig_a_flags))
-_cpp_flags     = $(KBUILD_CPPFLAGS) $(cppflags-y) $(CPPFLAGS_$(@F))
+                 $(asflags-y) $(AFLAGS_$*.o)
+_a_flags       = $(filter-out $(AFLAGS_REMOVE_$*.o), $(orig_a_flags))
+_cpp_flags     = $(KBUILD_CPPFLAGS) $(cppflags-y) $(CPPFLAGS_$*.lds)
 
 #
 # Enable gcov profiling flags for a file, directory or for all files depending
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index bed7a5a2fbe9..ef2f2336c469 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -166,15 +166,15 @@ $(obj)/nconf.o $(obj)/nconf.gui.o: $(obj)/nconf-cfg
 
 # mconf: Used for the menuconfig target based on lxdialog
 hostprogs-y	+= mconf
-lxdialog	:= checklist.o inputbox.o menubox.o textbox.o util.o yesno.o
-mconf-objs	:= mconf.o $(addprefix lxdialog/, $(lxdialog)) $(common-objs)
+lxdialog	:= $(addprefix lxdialog/, \
+		     checklist.o inputbox.o menubox.o textbox.o util.o yesno.o)
+mconf-objs	:= mconf.o $(lxdialog) $(common-objs)
 
 HOSTLDLIBS_mconf = $(shell . $(obj)/mconf-cfg && echo $$libs)
 $(foreach f, mconf.o $(lxdialog), \
   $(eval HOSTCFLAGS_$f = $$(shell . $(obj)/mconf-cfg && echo $$$$cflags)))
 
-$(obj)/mconf.o: $(obj)/mconf-cfg
-$(addprefix $(obj)/lxdialog/, $(lxdialog)): $(obj)/mconf-cfg
+$(addprefix $(obj)/, mconf.o $(lxdialog)): $(obj)/mconf-cfg
 
 # qconf: Used for the xconfig target based on Qt
 hostprogs-y	+= qconf
-- 
2.17.1

