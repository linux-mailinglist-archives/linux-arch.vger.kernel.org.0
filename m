Return-Path: <linux-arch+bounces-10353-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C68A43684
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2025 08:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065CA18904F9
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2025 07:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524C325A34C;
	Tue, 25 Feb 2025 07:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0teMHVg"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28011DF964;
	Tue, 25 Feb 2025 07:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740470063; cv=none; b=TpJgb65Cc6BoMACmHTNZcCh++mjloYP06o6m1sKLmDm0OewavPxYojjqqhTBpC9mDjp/Mma/J8Mgtg83rljf43Y1SW26JYVlKU7GDJHRZqOO9DorcUy4sdigvL49DHWN4SLu7m3V86DdTCsZGu9LQNJAnw02kRm1w21XMpzbJr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740470063; c=relaxed/simple;
	bh=ZlvG2IAy9/WbKTKDdfYpj4U3mpACPidtthX8myBMlsA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nIzHNnP+5iqv9R2Vo4LGu8hwJOm9YdE86855ViHl5h7S/HPxg1CtDK0j7QVriaOzuSC75MLf7XxfZF85vp0lcES0JSaVxmZ9CjwT81HdcS9bWzzKkvj0xEHP4r9OM4Yh1WuuhHOqkTb2Mg9cMnmzWqyx7D5O5TZVYfnLSIRKm6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0teMHVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F9DC4CEDD;
	Tue, 25 Feb 2025 07:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740470062;
	bh=ZlvG2IAy9/WbKTKDdfYpj4U3mpACPidtthX8myBMlsA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U0teMHVgm1rghOFx7Jf40jAPsleAuzshhWLyemY/KucX4XVCz7SyBnGJxD6u1Zlzb
	 Rd+BM56Z5WMG3LP7L9S/o6lTnRQOm+L4jUSwTkcqY+1nNS8OYeUwbIA5yQ3x0N0mDs
	 QhZlcAgb/v6ysfvl/6fQJF3X8yvIvc5ru9aIzmLUKRhQF83QVQ+NuENet7M/GuqNVN
	 Y8Q+KIJLZ+m5N/ktgpkM2toR5foiBtEUSACEuQ8o30WDAk1ldPpTzrQuG/3/XrHwcM
	 kW2iYSQBbpay2GgIobdc7S4utRuOyfiMLYRbCBSMNZLZEfPtyZHXQwWdR6c+cMGZPT
	 EADAmlAnil5JA==
Date: Tue, 25 Feb 2025 08:54:06 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Bingbu Cao
 <bingbu.cao@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Takashi Sakamoto
 <o-takashi@sakamocchi.jp>, Tianshu Qiu <tian.shu.qiu@intel.com>,
 linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 00/39] Implement kernel-doc in Python
Message-ID: <20250225085406.7fa87ee3@foz.lan>
In-Reply-To: <87msea29ah.fsf@trenco.lwn.net>
References: <cover.1740387599.git.mchehab+huawei@kernel.org>
	<87msea29ah.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 24 Feb 2025 16:49:10 -0700
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Hi Jon,
> >
> > This changeset contains the kernel-doc.py script to replace the verable
> > kernel-doc originally written in Perl. It replaces the first version and the
> > second series I sent on the top of it.  
> 
> I've sent minor comments on a couple of the patches.  The new version
> works for me, I can't find any real problems with it.

Good!

Btw, I should have sent this earlier, but what I did here to test here were
use the new V=1 output from Sphinx kerneldoc extension to get a list of
all kernel-doc commands used to build the docs. Then, I wrote an
ancillary script to do the diff, replacing kernel-doc calls to use 
the diff script. I'm enclosing the scripts I wrote with such approach,
as a patch.

Btw, I used the diff script also for the -man output, except that,
on such case, I just got all file names send them without any
arguments to -man parser.

> Here's the question: what were your thoughts on when to do this?  I can
> certainly take the initial fixup patches and get them out of your queue,
> but at some point there will be a need to dive into the deep end.  I'm
> just a bit leery of doing that as we head toward -rc5...  what do you
> think of "just after the merge window"?

There's no need to rush things there, provided that people refrain
touching the Perl version of kernel-doc. So yeah, postponing it to
the next merge window makes sense to me. Perhaps we should announce
somewhere that we're in the process of doing such replacement, asking
people to wait for 6.15-rc before sending any changes to kernel-doc.

> I'm definitely looking forward to no longer having to bash my head
> against the Perl version...

Yeah, the Perl version have too many global symbols, which makes it
hard for people to understand it. During the conversion, I also had
to bash my head a couple of times to get things right and - as you
can see from the fixup patches on this series - sometimes I just got
things wrong and had to come up with a completely different approach 
;-)

Regards,
Mauro

---

[PATCH] Test scripts to compare kernel-doc.pl with kernel-doc.py output

Those scripts are under GPLv2.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/check_all.sh b/check_all.sh
new file mode 100755
index 000000000000..2cc92b3c16cf
--- /dev/null
+++ b/check_all.sh
@@ -0,0 +1,1847 @@
+./diff-doc -rst -enable-lineno ./arch/s390/include/asm/debug.h
+./diff-doc -rst -enable-lineno ./arch/s390/kernel/debug.c
+./diff-doc -rst -enable-lineno ./block/blk-mq.c
+./diff-doc -rst -enable-lineno ./Documentation/gpu/rfc/i915_vm_bind.h
+./diff-doc -rst -enable-lineno ./drivers/ata/libata-eh.c
+./diff-doc -rst -enable-lineno ./drivers/base/devcoredump.c
+./diff-doc -rst -enable-lineno ./drivers/edac/edac_device.h
+./diff-doc -rst -enable-lineno ./drivers/edac/edac_mc.h
+./diff-doc -rst -enable-lineno ./drivers/edac/edac_pci.h
+./diff-doc -rst -enable-lineno ./drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+./diff-doc -rst -enable-lineno ./drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+./diff-doc -rst -enable-lineno ./drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+./diff-doc -rst -enable-lineno ./drivers/gpu/drm/i915/gem/i915_gem_context_types.h
+./diff-doc -rst -enable-lineno ./drivers/gpu/drm/i915/gt/uc/abi/guc_actions_abi.h
+./diff-doc -rst -enable-lineno ./drivers/gpu/drm/i915/gt/uc/abi/guc_communication_ctb_abi.h
+./diff-doc -rst -enable-lineno ./drivers/gpu/drm/i915/gt/uc/abi/guc_communication_mmio_abi.h
+./diff-doc -rst -enable-lineno ./drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h
+./diff-doc -rst -enable-lineno ./drivers/gpu/drm/i915/gt/uc/abi/guc_messages_abi.h
+./diff-doc -rst -enable-lineno ./drivers/gpu/drm/i915/gt/uc/intel_guc.h
+./diff-doc -rst -enable-lineno ./drivers/gpu/drm/i915/pxp/intel_pxp_types.h
+./diff-doc -rst -enable-lineno ./drivers/gpu/drm/xe/xe_assert.h
+./diff-doc -rst -enable-lineno ./drivers/gpu/drm/xlnx/zynqmp_disp.c
+./diff-doc -rst -enable-lineno ./drivers/gpu/drm/xlnx/zynqmp_disp.h
+./diff-doc -rst -enable-lineno ./drivers/gpu/drm/xlnx/zynqmp_dp.c
+./diff-doc -rst -enable-lineno ./drivers/gpu/drm/xlnx/zynqmp_dpsub.h
+./diff-doc -rst -enable-lineno ./drivers/gpu/drm/xlnx/zynqmp_kms.c
+./diff-doc -rst -enable-lineno ./drivers/gpu/drm/xlnx/zynqmp_kms.h
+./diff-doc -rst -enable-lineno ./drivers/i3c/device.c
+./diff-doc -rst -enable-lineno ./drivers/i3c/master.c
+./diff-doc -rst -enable-lineno ./drivers/iio/buffer/industrialio-triggered-buffer.c
+./diff-doc -rst -enable-lineno ./drivers/media/dvb-frontends/a8293.h
+./diff-doc -rst -enable-lineno ./drivers/media/dvb-frontends/af9013.h
+./diff-doc -rst -enable-lineno ./drivers/media/dvb-frontends/ascot2e.h
+./diff-doc -rst -enable-lineno ./drivers/media/dvb-frontends/cxd2820r.h
+./diff-doc -rst -enable-lineno ./drivers/media/dvb-frontends/drxk.h
+./diff-doc -rst -enable-lineno ./drivers/media/dvb-frontends/dvb-pll.h
+./diff-doc -rst -enable-lineno ./drivers/media/dvb-frontends/helene.h
+./diff-doc -rst -enable-lineno ./drivers/media/dvb-frontends/horus3a.h
+./diff-doc -rst -enable-lineno ./drivers/media/dvb-frontends/ix2505v.h
+./diff-doc -rst -enable-lineno ./drivers/media/dvb-frontends/m88ds3103.h
+./diff-doc -rst -enable-lineno ./drivers/media/dvb-frontends/mb86a20s.h
+./diff-doc -rst -enable-lineno ./drivers/media/dvb-frontends/mn88472.h
+./diff-doc -rst -enable-lineno ./drivers/media/dvb-frontends/rtl2830.h
+./diff-doc -rst -enable-lineno ./drivers/media/dvb-frontends/rtl2832.h
+./diff-doc -rst -enable-lineno ./drivers/media/dvb-frontends/rtl2832_sdr.h
+./diff-doc -rst -enable-lineno ./drivers/media/dvb-frontends/stb6000.h
+./diff-doc -rst -enable-lineno ./drivers/media/dvb-frontends/tda10071.h
+./diff-doc -rst -enable-lineno ./drivers/media/dvb-frontends/tda826x.h
+./diff-doc -rst -enable-lineno ./drivers/media/dvb-frontends/zd1301_demod.h
+./diff-doc -rst -enable-lineno ./drivers/media/dvb-frontends/zl10036.h
+./diff-doc -rst -enable-lineno ./drivers/media/i2c/ccs-pll.h
+./diff-doc -rst -enable-lineno ./drivers/media/test-drivers/vidtv/vidtv_bridge.h
+./diff-doc -rst -enable-lineno ./drivers/media/test-drivers/vidtv/vidtv_channel.h
+./diff-doc -rst -enable-lineno ./drivers/media/test-drivers/vidtv/vidtv_common.c
+./diff-doc -rst -enable-lineno ./drivers/media/test-drivers/vidtv/vidtv_demod.h
+./diff-doc -rst -enable-lineno ./drivers/media/test-drivers/vidtv/vidtv_encoder.h
+./diff-doc -rst -enable-lineno ./drivers/media/test-drivers/vidtv/vidtv_mux.h
+./diff-doc -rst -enable-lineno ./drivers/media/test-drivers/vidtv/vidtv_pes.h
+./diff-doc -rst -enable-lineno ./drivers/media/test-drivers/vidtv/vidtv_psi.h
+./diff-doc -rst -enable-lineno ./drivers/media/test-drivers/vidtv/vidtv_s302m.h
+./diff-doc -rst -enable-lineno ./drivers/media/test-drivers/vidtv/vidtv_ts.h
+./diff-doc -rst -enable-lineno ./drivers/media/test-drivers/vidtv/vidtv_tuner.c
+./diff-doc -rst -enable-lineno ./drivers/media/test-drivers/vidtv/vidtv_tuner.h
+./diff-doc -rst -enable-lineno ./drivers/media/test-drivers/vimc/vimc-streamer.c
+./diff-doc -rst -enable-lineno ./drivers/net/phy/phylink.c
+./diff-doc -rst -enable-lineno ./drivers/peci/core.c
+./diff-doc -rst -enable-lineno ./drivers/peci/cpu.c
+./diff-doc -rst -enable-lineno ./drivers/peci/internal.h
+./diff-doc -rst -enable-lineno ./drivers/peci/request.c
+./diff-doc -rst -enable-lineno ./drivers/platform/surface/aggregator/trace.h
+./diff-doc -rst -enable-lineno ./drivers/platform/x86/amd/wbrf.c
+./diff-doc -rst -enable-lineno ./drivers/platform/x86/intel/ifs/ifs.h
+./diff-doc -rst -enable-lineno ./drivers/scsi/scsi_proc.c
+./diff-doc -rst -enable-lineno ./drivers/staging/media/ipu3/include/uapi/intel-ipu3.h
+./diff-doc -rst -enable-lineno ./drivers/tty/tty_ioctl.c
+./diff-doc -rst -enable-lineno -export ./arch/sh/boards/mach-x3proto/ilsel.c
+./diff-doc -rst -enable-lineno -export ./arch/sh/kernel/cpu/sh4/sq.c
+./diff-doc -rst -enable-lineno -export ./arch/x86/kernel/cpu/mtrr/mtrr.c
+./diff-doc -rst -enable-lineno -export ./arch/x86/lib/usercopy_32.c
+./diff-doc -rst -enable-lineno -export ./block/bdev.c
+./diff-doc -rst -enable-lineno -export ./block/bio.c
+./diff-doc -rst -enable-lineno -export ./block/blk-core.c
+./diff-doc -rst -enable-lineno -export ./block/blk-flush.c
+./diff-doc -rst -enable-lineno -export ./block/blk-integrity.c
+./diff-doc -rst -enable-lineno -export ./block/blk-lib.c
+./diff-doc -rst -enable-lineno -export ./block/blk-map.c
+./diff-doc -rst -enable-lineno -export ./block/blk-settings.c
+./diff-doc -rst -enable-lineno -export ./block/genhd.c
+./diff-doc -rst -enable-lineno -export ./drivers/ata/libata-core.c
+./diff-doc -rst -enable-lineno -export ./drivers/ata/libata-scsi.c
+./diff-doc -rst -enable-lineno -export ./drivers/base/bus.c
+./diff-doc -rst -enable-lineno -export ./drivers/base/class.c
+./diff-doc -rst -enable-lineno -export ./drivers/base/component.c
+./diff-doc -rst -enable-lineno -export ./drivers/base/core.c
+./diff-doc -rst -enable-lineno -export ./drivers/base/dd.c
+./diff-doc -rst -enable-lineno -export ./drivers/base/devres.c
+./diff-doc -rst -enable-lineno -export ./drivers/base/driver.c
+./diff-doc -rst -enable-lineno -export ./drivers/base/platform.c
+./diff-doc -rst -enable-lineno -export ./drivers/base/syscore.c
+./diff-doc -rst -enable-lineno -export ./drivers/base/transport_class.c
+./diff-doc -rst -enable-lineno -export ./drivers/char/misc.c
+./diff-doc -rst -enable-lineno -export ./drivers/clk/clk_kunit_helpers.c
+./diff-doc -rst -enable-lineno -export ./drivers/counter/counter-chrdev.c
+./diff-doc -rst -enable-lineno -export ./drivers/counter/counter-core.c
+./diff-doc -rst -enable-lineno -export ./drivers/devfreq/devfreq.c
+./diff-doc -rst -enable-lineno -export ./drivers/devfreq/devfreq-event.c
+./diff-doc -rst -enable-lineno -export ./drivers/dma-buf/dma-buf.c
+./diff-doc -rst -enable-lineno -export ./drivers/dma-buf/dma-fence-array.c
+./diff-doc -rst -enable-lineno -export ./drivers/dma-buf/dma-fence.c
+./diff-doc -rst -enable-lineno -export ./drivers/dma-buf/dma-fence-chain.c
+./diff-doc -rst -enable-lineno -export ./drivers/dma-buf/dma-resv.c
+./diff-doc -rst -enable-lineno -export ./drivers/dma-buf/sync_file.c
+./diff-doc -rst -enable-lineno -export ./drivers/firewire/core-device.c
+./diff-doc -rst -enable-lineno -export ./drivers/firewire/core-iso.c
+./diff-doc -rst -enable-lineno -export ./drivers/firewire/core-transaction.c
+./diff-doc -rst -enable-lineno -export ./drivers/firmware/dmi_scan.c
+./diff-doc -rst -enable-lineno -export ./drivers/firmware/stratix10-svc.c
+./diff-doc -rst -enable-lineno -export ./drivers/firmware/sysfb.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpio/gpiolib-acpi.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpio/gpiolib.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpio/gpiolib-devres.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpio/gpiolib-of.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpio/gpiolib-sysfs.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/bridge/panel.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/display/drm_bridge_connector.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/display/drm_dp_cec.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/display/drm_dp_dual_mode_helper.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/display/drm_dp_helper.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/display/drm_dp_mst_topology.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/display/drm_dsc_helper.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/display/drm_hdcp_helper.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/display/drm_scdc_helper.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_atomic.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_atomic_helper.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_atomic_state_helper.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_atomic_uapi.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_auth.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_blend.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_bridge.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_buddy.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_cache.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_client.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_client_event.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_client_modeset.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_color_mgmt.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_connector.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_crtc.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_crtc_helper.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_damage_helper.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_debugfs.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_debugfs_crc.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_drv.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_edid.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_eld.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_encoder.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_exec.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_fb_dma_helper.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_fb_helper.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_file.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_flip_work.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_format_helper.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_fourcc.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_framebuffer.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_gem_atomic_helper.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_gem.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_gem_dma_helper.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_gem_framebuffer_helper.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_gem_shmem_helper.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_gem_ttm_helper.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_gem_vram_helper.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_gpuvm.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_ioc32.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_ioctl.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_managed.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_mipi_dbi.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_mipi_dsi.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_mm.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_mode_config.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_mode_object.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_modes.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_modeset_helper.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_modeset_lock.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_of.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_panel_backlight_quirks.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_panel.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_panel_orientation_quirks.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_panic.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_plane.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_plane_helper.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_prime.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_print.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_privacy_screen.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_probe_helper.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_property.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_rect.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_self_refresh_helper.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_simple_kms_helper.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_syncobj.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_sysfs.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_vblank.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_vblank_work.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_vma_manager.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/drm_writeback.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/scheduler/sched_entity.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/scheduler/sched_main.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/ttm/ttm_device.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/ttm/ttm_pool.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/ttm/ttm_resource.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/drm/ttm/ttm_tt.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/host1x/bus.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/host1x/syncpt.c
+./diff-doc -rst -enable-lineno -export ./drivers/gpu/vga/vga_switcheroo.c
+./diff-doc -rst -enable-lineno -export ./drivers/hsi/hsi_core.c
+./diff-doc -rst -enable-lineno -export ./drivers/i2c/i2c-core-base.c
+./diff-doc -rst -enable-lineno -export ./drivers/i2c/i2c-core-smbus.c
+./diff-doc -rst -enable-lineno -export ./drivers/iio/buffer/industrialio-hw-consumer.c
+./diff-doc -rst -enable-lineno -export ./drivers/iio/industrialio-buffer.c
+./diff-doc -rst -enable-lineno -export ./drivers/iio/industrialio-core.c
+./diff-doc -rst -enable-lineno -export ./drivers/iio/industrialio-trigger.c
+./diff-doc -rst -enable-lineno -export ./drivers/infiniband/core/cm.c
+./diff-doc -rst -enable-lineno -export ./drivers/infiniband/core/cq.c
+./diff-doc -rst -enable-lineno -export ./drivers/infiniband/core/device.c
+./diff-doc -rst -enable-lineno -export ./drivers/infiniband/core/packer.c
+./diff-doc -rst -enable-lineno -export ./drivers/infiniband/core/rw.c
+./diff-doc -rst -enable-lineno -export ./drivers/infiniband/core/sa_query.c
+./diff-doc -rst -enable-lineno -export ./drivers/infiniband/core/ud_header.c
+./diff-doc -rst -enable-lineno -export ./drivers/infiniband/core/umem.c
+./diff-doc -rst -enable-lineno -export ./drivers/infiniband/core/umem_odp.c
+./diff-doc -rst -enable-lineno -export ./drivers/infiniband/core/verbs.c
+./diff-doc -rst -enable-lineno -export ./drivers/infiniband/sw/rdmavt/ah.c
+./diff-doc -rst -enable-lineno -export ./drivers/infiniband/sw/rdmavt/cq.c
+./diff-doc -rst -enable-lineno -export ./drivers/infiniband/sw/rdmavt/mcast.c
+./diff-doc -rst -enable-lineno -export ./drivers/infiniband/sw/rdmavt/mr.c
+./diff-doc -rst -enable-lineno -export ./drivers/infiniband/sw/rdmavt/qp.c
+./diff-doc -rst -enable-lineno -export ./drivers/infiniband/sw/rdmavt/rc.c
+./diff-doc -rst -enable-lineno -export ./drivers/infiniband/sw/rdmavt/vt.c
+./diff-doc -rst -enable-lineno -export ./drivers/input/ff-core.c
+./diff-doc -rst -enable-lineno -export ./drivers/input/ff-memless.c
+./diff-doc -rst -enable-lineno -export ./drivers/input/input.c
+./diff-doc -rst -enable-lineno -export ./drivers/input/input-mt.c
+./diff-doc -rst -enable-lineno -export ./drivers/input/serio/libps2.c
+./diff-doc -rst -enable-lineno -export ./drivers/input/sparse-keymap.c
+./diff-doc -rst -enable-lineno -export ./drivers/iommu/iommufd/device.c
+./diff-doc -rst -enable-lineno -export ./drivers/iommu/iommufd/main.c
+./diff-doc -rst -enable-lineno -export ./drivers/media/v4l2-core/v4l2-jpeg.c
+./diff-doc -rst -enable-lineno -export ./drivers/message/fusion/mptbase.c
+./diff-doc -rst -enable-lineno -export ./drivers/message/fusion/mptscsih.c
+./diff-doc -rst -enable-lineno -export ./drivers/mtd/nand/raw/nand_base.c
+./diff-doc -rst -enable-lineno -export ./drivers/net/phy/mdio_bus.c
+./diff-doc -rst -enable-lineno -export ./drivers/net/phy/phy.c
+./diff-doc -rst -enable-lineno -export ./drivers/net/phy/phy-c45.c
+./diff-doc -rst -enable-lineno -export ./drivers/net/phy/phy-core.c
+./diff-doc -rst -enable-lineno -export ./drivers/net/phy/phy_device.c
+./diff-doc -rst -enable-lineno -export ./drivers/net/phy/sfp-bus.c
+./diff-doc -rst -enable-lineno -export ./drivers/nvmem/core.c
+./diff-doc -rst -enable-lineno -export ./drivers/of/address.c
+./diff-doc -rst -enable-lineno -export ./drivers/of/base.c
+./diff-doc -rst -enable-lineno -export ./drivers/of/device.c
+./diff-doc -rst -enable-lineno -export ./drivers/of/dynamic.c
+./diff-doc -rst -enable-lineno -export ./drivers/of/fdt.c
+./diff-doc -rst -enable-lineno -export ./drivers/of/irq.c
+./diff-doc -rst -enable-lineno -export ./drivers/of/of_kunit_helpers.c
+./diff-doc -rst -enable-lineno -export ./drivers/of/overlay.c
+./diff-doc -rst -enable-lineno -export ./drivers/of/platform.c
+./diff-doc -rst -enable-lineno -export ./drivers/of/property.c
+./diff-doc -rst -enable-lineno -export ./drivers/of/resolver.c
+./diff-doc -rst -enable-lineno -export ./drivers/parport/ieee1284.c
+./diff-doc -rst -enable-lineno -export ./drivers/parport/share.c
+./diff-doc -rst -enable-lineno -export ./drivers/pci/access.c
+./diff-doc -rst -enable-lineno -export ./drivers/pci/bus.c
+./diff-doc -rst -enable-lineno -export ./drivers/pci/devres.c
+./diff-doc -rst -enable-lineno -export ./drivers/pci/hotplug/pci_hotplug_core.c
+./diff-doc -rst -enable-lineno -export ./drivers/pci/iomap.c
+./diff-doc -rst -enable-lineno -export ./drivers/pci/iov.c
+./diff-doc -rst -enable-lineno -export ./drivers/pci/irq.c
+./diff-doc -rst -enable-lineno -export ./drivers/pci/msi/api.c
+./diff-doc -rst -enable-lineno -export ./drivers/pci/msi/msi.c
+./diff-doc -rst -enable-lineno -export ./drivers/pci/p2pdma.c
+./diff-doc -rst -enable-lineno -export ./drivers/pci/pci.c
+./diff-doc -rst -enable-lineno -export ./drivers/pci/pci-driver.c
+./diff-doc -rst -enable-lineno -export ./drivers/pci/probe.c
+./diff-doc -rst -enable-lineno -export ./drivers/pci/remove.c
+./diff-doc -rst -enable-lineno -export ./drivers/pci/rom.c
+./diff-doc -rst -enable-lineno -export ./drivers/pci/search.c
+./diff-doc -rst -enable-lineno -export ./drivers/pci/slot.c
+./diff-doc -rst -enable-lineno -export ./drivers/pci/tph.c
+./diff-doc -rst -enable-lineno -export ./drivers/pci/vgaarb.c
+./diff-doc -rst -enable-lineno -export ./drivers/platform/surface/aggregator/bus.c
+./diff-doc -rst -enable-lineno -export ./drivers/platform/surface/aggregator/controller.c
+./diff-doc -rst -enable-lineno -export ./drivers/platform/surface/aggregator/core.c
+./diff-doc -rst -enable-lineno -export ./drivers/platform/surface/aggregator/ssh_packet_layer.c
+./diff-doc -rst -enable-lineno -export ./drivers/platform/surface/surface_acpi_notify.c
+./diff-doc -rst -enable-lineno -export ./drivers/platform/x86/wmi.c
+./diff-doc -rst -enable-lineno -export ./drivers/pnp/card.c
+./diff-doc -rst -enable-lineno -export ./drivers/pnp/manager.c
+./diff-doc -rst -enable-lineno -export ./drivers/pnp/support.c
+./diff-doc -rst -enable-lineno -export ./drivers/power/sequencing/core.c
+./diff-doc -rst -enable-lineno -export ./drivers/pwm/core.c
+./diff-doc -rst -enable-lineno -export ./drivers/rapidio/rio.c
+./diff-doc -rst -enable-lineno -export ./drivers/rapidio/rio-driver.c
+./diff-doc -rst -enable-lineno -export ./drivers/regulator/core.c
+./diff-doc -rst -enable-lineno -export ./drivers/s390/cio/airq.c
+./diff-doc -rst -enable-lineno -export ./drivers/s390/cio/ccwgroup.c
+./diff-doc -rst -enable-lineno -export ./drivers/s390/cio/cmf.c
+./diff-doc -rst -enable-lineno -export ./drivers/s390/cio/device.c
+./diff-doc -rst -enable-lineno -export ./drivers/s390/cio/device_ops.c
+./diff-doc -rst -enable-lineno -export ./drivers/scsi/hosts.c
+./diff-doc -rst -enable-lineno -export ./drivers/scsi/iscsi_boot_sysfs.c
+./diff-doc -rst -enable-lineno -export ./drivers/scsi/libiscsi.c
+./diff-doc -rst -enable-lineno -export ./drivers/scsi/libiscsi_tcp.c
+./diff-doc -rst -enable-lineno -export ./drivers/scsi/scsi.c
+./diff-doc -rst -enable-lineno -export ./drivers/scsi/scsicam.c
+./diff-doc -rst -enable-lineno -export ./drivers/scsi/scsi_common.c
+./diff-doc -rst -enable-lineno -export ./drivers/scsi/scsi_devinfo.c
+./diff-doc -rst -enable-lineno -export ./drivers/scsi/scsi_error.c
+./diff-doc -rst -enable-lineno -export ./drivers/scsi/scsi_ioctl.c
+./diff-doc -rst -enable-lineno -export ./drivers/scsi/scsi_lib.c
+./diff-doc -rst -enable-lineno -export ./drivers/scsi/scsi_lib_dma.c
+./diff-doc -rst -enable-lineno -export ./drivers/scsi/scsi_scan.c
+./diff-doc -rst -enable-lineno -export ./drivers/scsi/scsi_sysfs.c
+./diff-doc -rst -enable-lineno -export ./drivers/scsi/scsi_transport_fc.c
+./diff-doc -rst -enable-lineno -export ./drivers/scsi/scsi_transport_iscsi.c
+./diff-doc -rst -enable-lineno -export ./drivers/scsi/scsi_transport_sas.c
+./diff-doc -rst -enable-lineno -export ./drivers/scsi/scsi_transport_spi.c
+./diff-doc -rst -enable-lineno -export ./drivers/scsi/scsi_transport_srp.c
+./diff-doc -rst -enable-lineno -export ./drivers/sh/maple/maple.c
+./diff-doc -rst -enable-lineno -export ./drivers/slimbus/core.c
+./diff-doc -rst -enable-lineno -export ./drivers/slimbus/messaging.c
+./diff-doc -rst -enable-lineno -export ./drivers/slimbus/sched.c
+./diff-doc -rst -enable-lineno -export ./drivers/slimbus/stream.c
+./diff-doc -rst -enable-lineno -export ./drivers/spi/spi.c
+./diff-doc -rst -enable-lineno -export ./drivers/staging/vme_user/vme.c
+./diff-doc -rst -enable-lineno -export ./drivers/target/target_core_transport.c
+./diff-doc -rst -enable-lineno -export ./drivers/tty/n_tty.c
+./diff-doc -rst -enable-lineno -export ./drivers/tty/serial/8250/8250_core.c
+./diff-doc -rst -enable-lineno -export ./drivers/tty/vt/selection.c
+./diff-doc -rst -enable-lineno -export ./drivers/tty/vt/vt.c
+./diff-doc -rst -enable-lineno -export ./drivers/uio/uio.c
+./diff-doc -rst -enable-lineno -export ./drivers/usb/common/common.c
+./diff-doc -rst -enable-lineno -export ./drivers/usb/core/driver.c
+./diff-doc -rst -enable-lineno -export ./drivers/usb/core/file.c
+./diff-doc -rst -enable-lineno -export ./drivers/usb/core/hcd.c
+./diff-doc -rst -enable-lineno -export ./drivers/usb/core/hcd-pci.c
+./diff-doc -rst -enable-lineno -export ./drivers/usb/core/hub.c
+./diff-doc -rst -enable-lineno -export ./drivers/usb/core/message.c
+./diff-doc -rst -enable-lineno -export ./drivers/usb/core/urb.c
+./diff-doc -rst -enable-lineno -export ./drivers/usb/core/usb.c
+./diff-doc -rst -enable-lineno -export ./drivers/usb/gadget/composite.c
+./diff-doc -rst -enable-lineno -export ./drivers/usb/gadget/config.c
+./diff-doc -rst -enable-lineno -export ./drivers/usb/gadget/usbstring.c
+./diff-doc -rst -enable-lineno -export ./drivers/video/aperture.c
+./diff-doc -rst -enable-lineno -export ./drivers/video/backlight/backlight.c
+./diff-doc -rst -enable-lineno -export ./drivers/video/fbdev/core/fbcmap.c
+./diff-doc -rst -enable-lineno -export ./drivers/video/fbdev/core/fbmem.c
+./diff-doc -rst -enable-lineno -export ./drivers/video/fbdev/core/modedb.c
+./diff-doc -rst -enable-lineno -export ./drivers/video/fbdev/macmodes.c
+./diff-doc -rst -enable-lineno -export ./drivers/video/hdmi.c
+./diff-doc -rst -enable-lineno -export ./drivers/w1/w1_family.c
+./diff-doc -rst -enable-lineno -export ./drivers/w1/w1_int.c
+./diff-doc -rst -enable-lineno -export ./drivers/w1/w1_io.c
+./diff-doc -rst -enable-lineno -export -export-file ./drivers/misc/mei/bus.c ./drivers/misc/mei/bus.c
+./diff-doc -rst -enable-lineno -export ./fs/anon_inodes.c
+./diff-doc -rst -enable-lineno -export ./fs/attr.c
+./diff-doc -rst -enable-lineno -export ./fs/bad_inode.c
+./diff-doc -rst -enable-lineno -export ./fs/buffer.c
+./diff-doc -rst -enable-lineno -export ./fs/char_dev.c
+./diff-doc -rst -enable-lineno -export ./fs/dax.c
+./diff-doc -rst -enable-lineno -export ./fs/dcache.c
+./diff-doc -rst -enable-lineno -export ./fs/debugfs/file.c
+./diff-doc -rst -enable-lineno -export ./fs/debugfs/inode.c
+./diff-doc -rst -enable-lineno -export ./fs/d_path.c
+./diff-doc -rst -enable-lineno -export ./fs/eventfd.c
+./diff-doc -rst -enable-lineno -export ./fs/filesystems.c
+./diff-doc -rst -enable-lineno -export ./fs/fs-writeback.c
+./diff-doc -rst -enable-lineno -export ./fs/inode.c
+./diff-doc -rst -enable-lineno -export ./fs/jbd2/journal.c
+./diff-doc -rst -enable-lineno -export ./fs/libfs.c
+./diff-doc -rst -enable-lineno -export ./fs/locks.c
+./diff-doc -rst -enable-lineno -export ./fs/mpage.c
+./diff-doc -rst -enable-lineno -export ./fs/namei.c
+./diff-doc -rst -enable-lineno -export ./fs/namespace.c
+./diff-doc -rst -enable-lineno -export ./fs/posix_acl.c
+./diff-doc -rst -enable-lineno -export ./fs/pstore/blk.c
+./diff-doc -rst -enable-lineno -export ./fs/seq_file.c
+./diff-doc -rst -enable-lineno -export ./fs/stat.c
+./diff-doc -rst -enable-lineno -export ./fs/super.c
+./diff-doc -rst -enable-lineno -export ./fs/sync.c
+./diff-doc -rst -enable-lineno -export ./fs/sysfs/file.c
+./diff-doc -rst -enable-lineno -export ./fs/sysfs/symlink.c
+./diff-doc -rst -enable-lineno -export ./fs/xattr.c
+./diff-doc -rst -enable-lineno -export ./kernel/audit.c
+./diff-doc -rst -enable-lineno -export ./kernel/cgroup/dmem.c
+./diff-doc -rst -enable-lineno -export ./kernel/dma.c
+./diff-doc -rst -enable-lineno -export ./kernel/dma/mapping.c
+./diff-doc -rst -enable-lineno -export ./kernel/irq/chip.c
+./diff-doc -rst -enable-lineno -export ./kernel/irq/generic-chip.c
+./diff-doc -rst -enable-lineno -export ./kernel/kthread.c
+./diff-doc -rst -enable-lineno -export ./kernel/livepatch/core.c
+./diff-doc -rst -enable-lineno -export ./kernel/livepatch/shadow.c
+./diff-doc -rst -enable-lineno -export ./kernel/livepatch/state.c
+./diff-doc -rst -enable-lineno -export ./kernel/locking/mutex.c
+./diff-doc -rst -enable-lineno -export ./kernel/module/kmod.c
+./diff-doc -rst -enable-lineno -export ./kernel/panic.c
+./diff-doc -rst -enable-lineno -export ./kernel/power/energy_model.c
+./diff-doc -rst -enable-lineno -export ./kernel/relay.c
+./diff-doc -rst -enable-lineno -export ./kernel/resource.c
+./diff-doc -rst -enable-lineno -export ./kernel/sched/core.c
+./diff-doc -rst -enable-lineno -export ./kernel/sched/wait.c
+./diff-doc -rst -enable-lineno -export ./kernel/sysctl.c
+./diff-doc -rst -enable-lineno -export ./kernel/time/hrtimer.c
+./diff-doc -rst -enable-lineno -export ./kernel/time/time.c
+./diff-doc -rst -enable-lineno -export ./kernel/time/timer.c
+./diff-doc -rst -enable-lineno -export ./lib/bitmap.c
+./diff-doc -rst -enable-lineno -export ./lib/cmdline.c
+./diff-doc -rst -enable-lineno -export ./lib/crc16.c
+./diff-doc -rst -enable-lineno -export ./lib/crc4.c
+./diff-doc -rst -enable-lineno -export ./lib/crc7.c
+./diff-doc -rst -enable-lineno -export ./lib/crc8.c
+./diff-doc -rst -enable-lineno -export ./lib/crc-ccitt.c
+./diff-doc -rst -enable-lineno -export ./lib/crc-itu-t.c
+./diff-doc -rst -enable-lineno -export ./lib/kobject.c
+./diff-doc -rst -enable-lineno -export ./lib/kstrtox.c
+./diff-doc -rst -enable-lineno -export ./lib/kunit/platform.c
+./diff-doc -rst -enable-lineno -export ./lib/list_sort.c
+./diff-doc -rst -enable-lineno -export ./lib/math/gcd.c
+./diff-doc -rst -enable-lineno -export ./lib/math/int_pow.c
+./diff-doc -rst -enable-lineno -export ./lib/math/int_sqrt.c
+./diff-doc -rst -enable-lineno -export ./lib/parser.c
+./diff-doc -rst -enable-lineno -export ./lib/reed_solomon/reed_solomon.c
+./diff-doc -rst -enable-lineno -export ./lib/refcount.c
+./diff-doc -rst -enable-lineno -export ./lib/sort.c
+./diff-doc -rst -enable-lineno -export ./lib/string.c
+./diff-doc -rst -enable-lineno -export ./lib/string_helpers.c
+./diff-doc -rst -enable-lineno -export ./lib/textsearch.c
+./diff-doc -rst -enable-lineno -export ./lib/uuid.c
+./diff-doc -rst -enable-lineno -export ./lib/vsprintf.c
+./diff-doc -rst -enable-lineno -export ./mm/dmapool.c
+./diff-doc -rst -enable-lineno -export ./mm/filemap.c
+./diff-doc -rst -enable-lineno -export ./mm/memory.c
+./diff-doc -rst -enable-lineno -export ./mm/mempool.c
+./diff-doc -rst -enable-lineno -export ./mm/page-writeback.c
+./diff-doc -rst -enable-lineno -export ./mm/readahead.c
+./diff-doc -rst -enable-lineno -export ./mm/slab_common.c
+./diff-doc -rst -enable-lineno -export ./mm/slub.c
+./diff-doc -rst -enable-lineno -export ./mm/truncate.c
+./diff-doc -rst -enable-lineno -export ./mm/vmalloc.c
+./diff-doc -rst -enable-lineno -export ./net/core/datagram.c
+./diff-doc -rst -enable-lineno -export ./net/core/dev.c
+./diff-doc -rst -enable-lineno -export ./net/core/filter.c
+./diff-doc -rst -enable-lineno -export ./net/core/gen_estimator.c
+./diff-doc -rst -enable-lineno -export ./net/core/gen_stats.c
+./diff-doc -rst -enable-lineno -export ./net/core/skbuff.c
+./diff-doc -rst -enable-lineno -export ./net/core/sock.c
+./diff-doc -rst -enable-lineno -export ./net/core/stream.c
+./diff-doc -rst -enable-lineno -export ./net/ethernet/eth.c
+./diff-doc -rst -enable-lineno -export ./net/sched/sch_generic.c
+./diff-doc -rst -enable-lineno -export ./net/socket.c
+./diff-doc -rst -enable-lineno -export ./net/sunrpc/clnt.c
+./diff-doc -rst -enable-lineno -export ./net/sunrpc/rpcb_clnt.c
+./diff-doc -rst -enable-lineno -export ./net/sunrpc/rpc_pipe.c
+./diff-doc -rst -enable-lineno -export ./net/sunrpc/sched.c
+./diff-doc -rst -enable-lineno -export ./net/sunrpc/socklib.c
+./diff-doc -rst -enable-lineno -export ./net/sunrpc/stats.c
+./diff-doc -rst -enable-lineno -export ./net/sunrpc/svc_xprt.c
+./diff-doc -rst -enable-lineno -export ./net/sunrpc/xdr.c
+./diff-doc -rst -enable-lineno -export ./net/sunrpc/xprt.c
+./diff-doc -rst -enable-lineno -export -nosymbol printk ./kernel/printk/printk.c
+./diff-doc -rst -enable-lineno -export ./security/inode.c
+./diff-doc -rst -enable-lineno -export ./security/security.c
+./diff-doc -rst -enable-lineno ./fs/jbd2/transaction.c
+./diff-doc -rst -enable-lineno ./fs/netfs/buffered_read.c
+./diff-doc -rst -enable-lineno ./fs/pipe.c
+./diff-doc -rst -enable-lineno ./fs/splice.c
+./diff-doc -rst -enable-lineno -function acoustic_limit_rpm_threshold ./drivers/gpu/drm/amd/pm/amdgpu_pm.c
+./diff-doc -rst -enable-lineno -function acoustic_target_rpm_threshold ./drivers/gpu/drm/amd/pm/amdgpu_pm.c
+./diff-doc -rst -enable-lineno -function 'Actions and configuration' ./include/net/cfg80211.h
+./diff-doc -rst -enable-lineno -function aead_request -function aead_alg ./include/crypto/aead.h
+./diff-doc -rst -enable-lineno -function ahash_request_set_tfm -function ahash_request_alloc -function ahash_request_free -function ahash_request_set_callback -function ahash_request_set_crypt ./include/crypto/hash.h
+./diff-doc -rst -enable-lineno -function akcipher_alg -function akcipher_request ./include/crypto/akcipher.h
+./diff-doc -rst -enable-lineno -function akcipher_request_alloc -function akcipher_request_free -function akcipher_request_set_callback -function akcipher_request_set_crypt ./include/crypto/akcipher.h
+./diff-doc -rst -enable-lineno -function amdgpu_dm_atomic_check -function amdgpu_dm_atomic_commit_tail ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+./diff-doc -rst -enable-lineno -function amdgpu_object ./drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+./diff-doc -rst -enable-lineno -function 'AMDGPU RAS debugfs control interface' ./drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+./diff-doc -rst -enable-lineno -function 'AMDGPU RAS debugfs EEPROM table reset interface' ./drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+./diff-doc -rst -enable-lineno -function 'AMDGPU RAS Reboot Behavior for Unrecoverable Errors' ./drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+./diff-doc -rst -enable-lineno -function 'AMDGPU RAS sysfs Error Count Interface' ./drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+./diff-doc -rst -enable-lineno -function 'AMDGPU RAS sysfs gpu_vram_bad_pages Interface' ./drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+./diff-doc -rst -enable-lineno -function amd_ip_block_type -function amd_ip_funcs -function DC_DEBUG_MASK ./drivers/gpu/drm/amd/include/amd_shared.h
+./diff-doc -rst -enable-lineno -function 'Analog TV Connector Properties' ./drivers/gpu/drm/drm_connector.c
+./diff-doc -rst -enable-lineno -function 'AP support for powersaving clients' ./include/net/mac80211.h
+./diff-doc -rst -enable-lineno -function 'ARM PrimeCell PL110 and PL111 CLCD Driver' ./drivers/gpu/drm/pl111/pl111_drv.c
+./diff-doc -rst -enable-lineno -function ASSERT_EQ -function ASSERT_NE -function ASSERT_LT -function ASSERT_LE -function ASSERT_GT -function ASSERT_GE -function ASSERT_NULL -function ASSERT_TRUE -function ASSERT_NULL -function ASSERT_TRUE -function ASSERT_FALSE -function ASSERT_STREQ -function ASSERT_STRNE -function EXPECT_EQ -function EXPECT_NE -function EXPECT_LT -function EXPECT_LE -function EXPECT_GT -function EXPECT_GE -function EXPECT_NULL -function EXPECT_TRUE -function EXPECT_FALSE -function EXPECT_STREQ -function EXPECT_STRNE ./tools/testing/selftests/kselftest_harness.h
+./diff-doc -rst -enable-lineno -function ASSERT_EXCLUSIVE_WRITER -function ASSERT_EXCLUSIVE_WRITER_SCOPED -function ASSERT_EXCLUSIVE_ACCESS -function ASSERT_EXCLUSIVE_ACCESS_SCOPED -function ASSERT_EXCLUSIVE_BITS ./include/linux/kcsan-checks.h
+./diff-doc -rst -enable-lineno -function 'Asynchronous AEAD Request Handle' ./include/crypto/aead.h
+./diff-doc -rst -enable-lineno -function 'asynchronous flip implementation' ./drivers/gpu/drm/i915/display/intel_display.c
+./diff-doc -rst -enable-lineno -function 'Asynchronous Hash Request Handle' ./include/crypto/hash.h
+./diff-doc -rst -enable-lineno -function 'Asynchronous Message Digest API' ./include/crypto/hash.h
+./diff-doc -rst -enable-lineno -function atomic ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+./diff-doc -rst -enable-lineno -function 'atomic plane helpers' ./drivers/gpu/drm/i915/display/intel_atomic_plane.c
+./diff-doc -rst -enable-lineno -function 'atomic state reset and initialization' ./drivers/gpu/drm/drm_atomic_state_helper.c
+./diff-doc -rst -enable-lineno -function 'Authenticated Encryption With Associated Data (AEAD) Cipher API' ./include/crypto/aead.h
+./diff-doc -rst -enable-lineno -function auxiliary_device ./include/linux/auxiliary_bus.h
+./diff-doc -rst -enable-lineno -function auxiliary_device_init -function __auxiliary_device_add ./drivers/base/auxiliary.c
+./diff-doc -rst -enable-lineno -function auxiliary_driver -function module_auxiliary_driver ./include/linux/auxiliary_bus.h
+./diff-doc -rst -enable-lineno -function __auxiliary_driver_register -function auxiliary_driver_unregister ./drivers/base/auxiliary.c
+./diff-doc -rst -enable-lineno -function 'aux kms helpers' ./drivers/gpu/drm/drm_modeset_helper.c
+./diff-doc -rst -enable-lineno -function 'Backlight control' ./drivers/platform/x86/apple-gmux.c
+./diff-doc -rst -enable-lineno -function 'Basic sk_buff geometry' ./include/linux/skbuff.h
+./diff-doc -rst -enable-lineno -function 'batch buffer command parser' ./drivers/gpu/drm/i915/i915_cmd_parser.c
+./diff-doc -rst -enable-lineno -function 'Beacon filter support' ./include/net/mac80211.h
+./diff-doc -rst -enable-lineno -function 'bitmap bitops' ./include/linux/bitmap.h
+./diff-doc -rst -enable-lineno -function 'bitmap introduction' ./lib/bitmap.c
+./diff-doc -rst -enable-lineno -function 'bitmap overview' ./include/linux/bitmap.h
+./diff-doc -rst -enable-lineno -function 'Block Cipher Algorithm Definitions' ./include/linux/crypto.h
+./diff-doc -rst -enable-lineno -function board_info ./drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+./diff-doc -rst -enable-lineno -function bpf_cgroup_acquire -function bpf_cgroup_release ./kernel/bpf/helpers.c
+./diff-doc -rst -enable-lineno -function bpf_cgroup_ancestor ./kernel/bpf/helpers.c
+./diff-doc -rst -enable-lineno -function bpf_cgroup_from_id ./kernel/bpf/helpers.c
+./diff-doc -rst -enable-lineno -function bpf_cpumask_acquire ./kernel/bpf/cpumask.c
+./diff-doc -rst -enable-lineno -function bpf_cpumask_and -function bpf_cpumask_or -function bpf_cpumask_xor ./kernel/bpf/cpumask.c
+./diff-doc -rst -enable-lineno -function bpf_cpumask_any_distribute -function bpf_cpumask_any_and_distribute ./kernel/bpf/cpumask.c
+./diff-doc -rst -enable-lineno -function bpf_cpumask_copy ./kernel/bpf/cpumask.c
+./diff-doc -rst -enable-lineno -function bpf_cpumask_create ./kernel/bpf/cpumask.c
+./diff-doc -rst -enable-lineno -function bpf_cpumask_equal -function bpf_cpumask_intersects -function bpf_cpumask_subset -function bpf_cpumask_empty -function bpf_cpumask_full ./kernel/bpf/cpumask.c
+./diff-doc -rst -enable-lineno -function bpf_cpumask_first -function bpf_cpumask_first_zero -function bpf_cpumask_first_and -function bpf_cpumask_test_cpu -function bpf_cpumask_weight ./kernel/bpf/cpumask.c
+./diff-doc -rst -enable-lineno -function bpf_cpumask_release ./kernel/bpf/cpumask.c
+./diff-doc -rst -enable-lineno -function bpf_cpumask_setall -function bpf_cpumask_clear ./kernel/bpf/cpumask.c
+./diff-doc -rst -enable-lineno -function bpf_cpumask_set_cpu -function bpf_cpumask_clear_cpu ./kernel/bpf/cpumask.c
+./diff-doc -rst -enable-lineno -function bpf_cpumask_test_and_set_cpu -function bpf_cpumask_test_and_clear_cpu ./kernel/bpf/cpumask.c
+./diff-doc -rst -enable-lineno -function bpf_task_acquire -function bpf_task_release ./kernel/bpf/helpers.c
+./diff-doc -rst -enable-lineno -function bpf_task_from_pid ./kernel/bpf/helpers.c
+./diff-doc -rst -enable-lineno -function bpf_xdp_metadata_rx_hash ./net/core/xdp.c
+./diff-doc -rst -enable-lineno -function bpf_xdp_metadata_rx_timestamp ./net/core/xdp.c
+./diff-doc -rst -enable-lineno -function bpf_xdp_metadata_rx_vlan_tag ./net/core/xdp.c
+./diff-doc -rst -enable-lineno -function 'Branch device and port refcounting' ./drivers/gpu/drm/display/drm_dp_mst_topology.c
+./diff-doc -rst -enable-lineno -function 'Bridge enum definition' ./include/uapi/linux/if_link.h
+./diff-doc -rst -enable-lineno -function 'bridge operations' ./drivers/gpu/drm/drm_bridge.c
+./diff-doc -rst -enable-lineno -function 'Bridge port enum definition' ./include/uapi/linux/if_link.h
+./diff-doc -rst -enable-lineno -function 'Broadcom V3D Graphics Driver' ./drivers/gpu/drm/v3d/v3d_drv.c
+./diff-doc -rst -enable-lineno -function 'Broadcom V3D MMU' ./drivers/gpu/drm/v3d/v3d_mmu.c
+./diff-doc -rst -enable-lineno -function 'Broadcom V3D scheduling' ./drivers/gpu/drm/v3d/v3d_sched.c
+./diff-doc -rst -enable-lineno -function 'Broadcom VC4 Graphics Driver' ./drivers/gpu/drm/vc4/vc4_drv.c
+./diff-doc -rst -enable-lineno -function 'Buffer Objects (BO)' ./drivers/gpu/drm/xe/xe_bo_doc.h
+./diff-doc -rst -enable-lineno -function 'buffer object tiling' ./drivers/gpu/drm/i915/gem/i915_gem_tiling.c
+./diff-doc -rst -enable-lineno -function 'Buffers allocated by the backend' ./drivers/gpu/drm/xen/xen_drm_front.h
+./diff-doc -rst -enable-lineno -function 'Buffers allocated by the frontend driver' ./drivers/gpu/drm/xen/xen_drm_front.h
+./diff-doc -rst -enable-lineno -function bus_type -function bus_notifier_event ./include/linux/device/bus.h
+./diff-doc -rst -enable-lineno -function 'Calling mac80211 from interrupts' ./include/net/mac80211.h
+./diff-doc -rst -enable-lineno -function 'CDCLK / RAWCLK' ./drivers/gpu/drm/i915/display/intel_cdclk.c
+./diff-doc -rst -enable-lineno -function cfg80211_ops -function vif_params -function key_params -function survey_info_flags -function survey_info -function cfg80211_beacon_data -function cfg80211_ap_settings -function station_parameters -function rate_info_flags -function rate_info -function station_info -function monitor_flags -function mpath_info_flags -function mpath_info -function bss_parameters -function ieee80211_txq_params -function cfg80211_crypto_settings -function cfg80211_auth_request -function cfg80211_assoc_request -function cfg80211_deauth_request -function cfg80211_disassoc_request -function cfg80211_ibss_params -function cfg80211_connect_params -function cfg80211_pmksa -function cfg80211_rx_mlme_mgmt -function cfg80211_auth_timeout -function cfg80211_rx_assoc_resp -function cfg80211_assoc_timeout -function cfg80211_tx_mlme_mgmt -function cfg80211_ibss_joined -function cfg80211_connect_resp_params -function cfg80211_connect_done -function cfg80211_connect_result -func
 tion cfg80211_connect_bss -function cfg80211_connect_timeout -function cfg80211_roamed -function cfg80211_disconnected -function cfg80211_ready_on_channel -function cfg80211_remain_on_channel_expired -function cfg80211_new_sta -function cfg80211_rx_mgmt -function cfg80211_mgmt_tx_status -function cfg80211_cqm_rssi_notify -function cfg80211_cqm_pktloss_notify -function cfg80211_michael_mic_failure ./include/net/cfg80211.h
+./diff-doc -rst -enable-lineno -function cfg80211_ssid -function cfg80211_scan_request -function cfg80211_scan_done -function cfg80211_bss -function cfg80211_inform_bss -function cfg80211_inform_bss_frame_data -function cfg80211_inform_bss_data -function cfg80211_unlink_bss -function cfg80211_find_ie -function ieee80211_bss_get_ie ./include/net/cfg80211.h
+./diff-doc -rst -enable-lineno -function cfg80211_testmode_alloc_reply_skb -function cfg80211_testmode_reply -function cfg80211_testmode_alloc_event_skb -function cfg80211_testmode_event ./include/net/cfg80211.h
+./diff-doc -rst -enable-lineno -function class ./include/linux/device/class.h
+./diff-doc -rst -enable-lineno -function color-management-caps ./drivers/gpu/drm/amd/display/dc/dc.h
+./diff-doc -rst -enable-lineno -function 'Command list validator for VC4.' ./drivers/gpu/drm/vc4/vc4_validate.c
+./diff-doc -rst -enable-lineno -function 'component helper usage recommendations' ./drivers/gpu/drm/drm_drv.c
+./diff-doc -rst -enable-lineno -function console -function cons_flags ./include/linux/console.h
+./diff-doc -rst -enable-lineno -function console_srcu_read_flags -function console_srcu_write_flags -function console_is_registered -function for_each_console_srcu -function for_each_console ./include/linux/console.h
+./diff-doc -rst -enable-lineno -function consw ./include/linux/console.h
+./diff-doc -rst -enable-lineno -function 'cpu access' ./drivers/dma-buf/dma-buf.c
+./diff-doc -rst -enable-lineno -function 'cpu map' ./kernel/bpf/cpumap.c
+./diff-doc -rst -enable-lineno -function 'CRC ABI' ./drivers/gpu/drm/drm_debugfs_crc.c
+./diff-doc -rst -enable-lineno -function crypto_aead_reqsize -function aead_request_set_tfm -function aead_request_alloc -function aead_request_free -function aead_request_set_callback -function aead_request_set_crypt -function aead_request_set_ad ./include/crypto/aead.h
+./diff-doc -rst -enable-lineno -function crypto_alg -function cipher_alg -function compress_alg ./include/linux/crypto.h
+./diff-doc -rst -enable-lineno -function crypto_alloc_aead -function crypto_free_aead -function crypto_aead_ivsize -function crypto_aead_authsize -function crypto_aead_blocksize -function crypto_aead_setkey -function crypto_aead_setauthsize -function crypto_aead_encrypt -function crypto_aead_decrypt ./include/crypto/aead.h
+./diff-doc -rst -enable-lineno -function crypto_alloc_ahash -function crypto_free_ahash -function crypto_ahash_init -function crypto_ahash_digestsize -function crypto_ahash_reqtfm -function crypto_ahash_reqsize -function crypto_ahash_statesize -function crypto_ahash_setkey -function crypto_ahash_finup -function crypto_ahash_final -function crypto_ahash_digest -function crypto_ahash_export -function crypto_ahash_import ./include/crypto/hash.h
+./diff-doc -rst -enable-lineno -function crypto_alloc_akcipher -function crypto_free_akcipher -function crypto_akcipher_set_pub_key -function crypto_akcipher_set_priv_key -function crypto_akcipher_maxsize -function crypto_akcipher_encrypt -function crypto_akcipher_decrypt ./include/crypto/akcipher.h
+./diff-doc -rst -enable-lineno -function crypto_alloc_cipher -function crypto_free_cipher -function crypto_has_cipher -function crypto_cipher_blocksize -function crypto_cipher_setkey -function crypto_cipher_encrypt_one -function crypto_cipher_decrypt_one ./include/crypto/internal/cipher.h
+./diff-doc -rst -enable-lineno -function crypto_alloc_kpp -function crypto_free_kpp -function crypto_kpp_set_secret -function crypto_kpp_generate_public_key -function crypto_kpp_compute_shared_secret -function crypto_kpp_maxsize ./include/crypto/kpp.h
+./diff-doc -rst -enable-lineno -function crypto_alloc_rng -function crypto_rng_alg -function crypto_free_rng -function crypto_rng_generate -function crypto_rng_get_bytes -function crypto_rng_reset -function crypto_rng_seedsize ./include/crypto/rng.h
+./diff-doc -rst -enable-lineno -function crypto_alloc_shash -function crypto_free_shash -function crypto_shash_blocksize -function crypto_shash_digestsize -function crypto_shash_descsize -function crypto_shash_setkey -function crypto_shash_digest -function crypto_shash_export -function crypto_shash_import -function crypto_shash_init -function crypto_shash_update -function crypto_shash_final -function crypto_shash_finup ./include/crypto/hash.h
+./diff-doc -rst -enable-lineno -function crypto_alloc_sig -function crypto_free_sig -function crypto_sig_set_pubkey -function crypto_sig_set_privkey -function crypto_sig_keysize -function crypto_sig_maxsize -function crypto_sig_digestsize -function crypto_sig_sign -function crypto_sig_verify ./include/crypto/sig.h
+./diff-doc -rst -enable-lineno -function crypto_alloc_skcipher -function crypto_free_skcipher -function crypto_has_skcipher -function crypto_skcipher_ivsize -function crypto_skcipher_blocksize -function crypto_skcipher_setkey -function crypto_skcipher_reqtfm -function crypto_skcipher_encrypt -function crypto_skcipher_decrypt ./include/crypto/skcipher.h
+./diff-doc -rst -enable-lineno -function crypto_skcipher_reqsize -function skcipher_request_set_tfm -function skcipher_request_alloc -function skcipher_request_free -function skcipher_request_set_callback -function skcipher_request_set_crypt ./include/crypto/skcipher.h
+./diff-doc -rst -enable-lineno -function 'CSS-based Firmware Layout' ./drivers/gpu/drm/xe/xe_uc_fw_abi.h
+./diff-doc -rst -enable-lineno -function 'cxl core' ./drivers/cxl/core/port.c
+./diff-doc -rst -enable-lineno -function 'cxl core hdm' ./drivers/cxl/core/hdm.c
+./diff-doc -rst -enable-lineno -function 'cxl core pci' ./drivers/cxl/core/pci.c
+./diff-doc -rst -enable-lineno -function 'cxl core region' ./drivers/cxl/core/region.c
+./diff-doc -rst -enable-lineno -function 'cxl mbox' ./drivers/cxl/core/mbox.c
+./diff-doc -rst -enable-lineno -function 'cxl mem' ./drivers/cxl/mem.c
+./diff-doc -rst -enable-lineno -function 'cxl objects' ./drivers/cxl/cxl.h
+./diff-doc -rst -enable-lineno -function 'cxl pci' ./drivers/cxl/pci.c
+./diff-doc -rst -enable-lineno -function 'cxl pmem' ./drivers/cxl/core/pmem.c
+./diff-doc -rst -enable-lineno -function 'cxl port' ./drivers/cxl/port.c
+./diff-doc -rst -enable-lineno -function 'cxl registers' ./drivers/cxl/core/regs.c
+./diff-doc -rst -enable-lineno -function 'damage tracking' ./drivers/gpu/drm/drm_plane.c
+./diff-doc -rst -enable-lineno -function 'Data path helpers' ./include/net/cfg80211.h
+./diff-doc -rst -enable-lineno -function 'dataref and headerless skbs' ./include/linux/skbuff.h
+./diff-doc -rst -enable-lineno -function 'dcp blob format' ./security/keys/trusted-keys/trusted_dcp.c
+./diff-doc -rst -enable-lineno -function 'deadline hints' ./drivers/dma-buf/dma-fence.c
+./diff-doc -rst -enable-lineno -function debug_object_activate ./lib/debugobjects.c
+./diff-doc -rst -enable-lineno -function debug_object_assert_init ./lib/debugobjects.c
+./diff-doc -rst -enable-lineno -function debug_object_deactivate ./lib/debugobjects.c
+./diff-doc -rst -enable-lineno -function debug_object_destroy ./lib/debugobjects.c
+./diff-doc -rst -enable-lineno -function debug_object_free ./lib/debugobjects.c
+./diff-doc -rst -enable-lineno -function debug_object_init ./lib/debugobjects.c
+./diff-doc -rst -enable-lineno -function debug_object_init_on_stack ./lib/debugobjects.c
+./diff-doc -rst -enable-lineno -function 'declare bitmap' ./include/linux/bitmap.h
+./diff-doc -rst -enable-lineno -function descriptors ./include/uapi/linux/usb/functionfs.h
+./diff-doc -rst -enable-lineno -function DEVICE_LIFESPAN ./include/linux/auxiliary_bus.h
+./diff-doc -rst -enable-lineno -function device_link_state ./include/linux/device.h
+./diff-doc -rst -enable-lineno -function 'Device registration' ./include/net/cfg80211.h
+./diff-doc -rst -enable-lineno -function __devm_fpga_mgr_register ./drivers/fpga/fpga-mgr.c
+./diff-doc -rst -enable-lineno -function __devm_fpga_mgr_register_full ./drivers/fpga/fpga-mgr.c
+./diff-doc -rst -enable-lineno -function devm_gen_pool_create ./lib/genalloc.c
+./diff-doc -rst -enable-lineno -function devm_hte_register_chip -function hte_push_ts_ns ./drivers/hte/hte.c
+./diff-doc -rst -enable-lineno -function dh -function crypto_dh_key_len -function crypto_dh_encode_key -function crypto_dh_decode_key ./include/crypto/dh.h
+./diff-doc -rst -enable-lineno -function 'DH Helper Functions' ./include/crypto/dh.h
+./diff-doc -rst -enable-lineno -function 'display driver integration' ./drivers/gpu/drm/drm_bridge.c
+./diff-doc -rst -enable-lineno -function 'Display PLLs' ./drivers/gpu/drm/i915/display/intel_dpll_mgr.c
+./diff-doc -rst -enable-lineno -function 'Display Refresh Rate Switching (DRRS)' ./drivers/gpu/drm/i915/display/intel_drrs.c
+./diff-doc -rst -enable-lineno -function 'dma buf device access' ./drivers/dma-buf/dma-buf.c
+./diff-doc -rst -enable-lineno -function 'DMA fences overview' ./drivers/dma-buf/dma-fence.c
+./diff-doc -rst -enable-lineno -function 'dma helpers' ./drivers/gpu/drm/drm_gem_dma_helper.c
+./diff-doc -rst -enable-lineno -function 'DMC Firmware Support' ./drivers/gpu/drm/i915/display/intel_dmc.c
+./diff-doc -rst -enable-lineno -function 'DMC wakelock support' ./drivers/gpu/drm/i915/display/intel_dmc_wl.c
+./diff-doc -rst -enable-lineno -function dm_hw_init -function dm_hw_fini ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+./diff-doc -rst -enable-lineno -function 'DM Lifecycle' ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+./diff-doc -rst -enable-lineno -function do_div ./include/asm-generic/div64.h
+./diff-doc -rst -enable-lineno -function 'dp cec helpers' ./drivers/gpu/drm/display/drm_dp_cec.c
+./diff-doc -rst -enable-lineno -function 'dp dual mode helpers' ./drivers/gpu/drm/display/drm_dp_dual_mode_helper.c
+./diff-doc -rst -enable-lineno -function 'dp helpers' ./drivers/gpu/drm/display/drm_dp_helper.c
+./diff-doc -rst -enable-lineno -function DPIO ./drivers/gpu/drm/i915/display/intel_dpio_phy.c
+./diff-doc -rst -enable-lineno -function 'dp mst helper' ./drivers/gpu/drm/display/drm_dp_mst_topology.c
+./diff-doc -rst -enable-lineno -function 'driver instance overview' ./drivers/gpu/drm/drm_drv.c
+./diff-doc -rst -enable-lineno -function 'Driver limitations' ./drivers/gpu/drm/xen/xen_drm_front.h
+./diff-doc -rst -enable-lineno -function 'Driver modes of operation in terms of display buffers used' ./drivers/gpu/drm/xen/xen_drm_front.h
+./diff-doc -rst -enable-lineno -function 'Driver power control' ./drivers/gpu/vga/vga_switcheroo.c
+./diff-doc -rst -enable-lineno -function 'driver specific ioctls' ./drivers/gpu/drm/drm_ioctl.c
+./diff-doc -rst -enable-lineno -function 'DRM Client usage stats' ./drivers/gpu/drm/xe/xe_drm_client.c
+./diff-doc -rst -enable-lineno -function drm_dp_mst_topology_try_get_mstb -function drm_dp_mst_topology_get_mstb -function drm_dp_mst_topology_put_mstb -function drm_dp_mst_topology_try_get_port -function drm_dp_mst_topology_get_port -function drm_dp_mst_topology_put_port -function drm_dp_mst_get_mstb_malloc -function drm_dp_mst_put_mstb_malloc ./drivers/gpu/drm/display/drm_dp_mst_topology.c
+./diff-doc -rst -enable-lineno -function __drm_i915_gem_create_ext ./Documentation/gpu/rfc/i915_small_bar.h
+./diff-doc -rst -enable-lineno -function __drm_i915_memory_region_info ./Documentation/gpu/rfc/i915_small_bar.h
+./diff-doc -rst -enable-lineno -function 'drm leasing' ./drivers/gpu/drm/drm_lease.c
+./diff-doc -rst -enable-lineno -function 'drm panel' ./drivers/gpu/drm/drm_panel.c
+./diff-doc -rst -enable-lineno -function drm_pvr_create_hwrt_geom_data_args -function drm_pvr_create_hwrt_rt_data_args ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function drm_pvr_ctx_priority -function drm_pvr_ctx_type -function drm_pvr_static_render_context_state -function drm_pvr_static_render_context_state_format -function drm_pvr_reset_framework -function drm_pvr_reset_framework_format ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function drm_pvr_dev_query_gpu_info -function drm_pvr_dev_query_runtime_info -function drm_pvr_dev_query_hwrt_info -function drm_pvr_dev_query_quirks -function drm_pvr_dev_query_enhancements ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function drm_pvr_dev_query ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function drm_pvr_heap_id -function drm_pvr_heap -function drm_pvr_dev_query_heap_info ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function drm_pvr_ioctl_create_bo_args ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function drm_pvr_ioctl_create_context_args ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function drm_pvr_ioctl_create_free_list_args ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function drm_pvr_ioctl_create_hwrt_dataset_args ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function drm_pvr_ioctl_create_vm_context_args -function drm_pvr_ioctl_destroy_vm_context_args ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function drm_pvr_ioctl_destroy_context_args ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function drm_pvr_ioctl_destroy_free_list_args ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function drm_pvr_ioctl_destroy_hwrt_dataset_args ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function drm_pvr_ioctl_dev_query_args ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function drm_pvr_ioctl_get_bo_mmap_offset_args ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function drm_pvr_ioctl_submit_jobs_args ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function drm_pvr_ioctl_vm_map_args -function drm_pvr_ioctl_vm_unmap_args ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function drm_pvr_obj_array ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function DRM_PVR_OBJ_ARRAY ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function drm_pvr_static_data_area_usage -function drm_pvr_static_data_area -function drm_pvr_dev_query_static_data_areas ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function drm_pvr_sync_op -function drm_pvr_job_type -function drm_pvr_hwrt_data_ref -function drm_pvr_job ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function 'drm utils' ./include/drm/drm_util.h
+./diff-doc -rst -enable-lineno -function DSB ./drivers/gpu/drm/i915/display/intel_dsb.c
+./diff-doc -rst -enable-lineno -function 'dsc helpers' ./drivers/gpu/drm/display/drm_dsc_helper.c
+./diff-doc -rst -enable-lineno -function 'dsi bridge operations' ./drivers/gpu/drm/drm_bridge.c
+./diff-doc -rst -enable-lineno -function 'dsi helpers' ./drivers/gpu/drm/drm_mipi_dsi.c
+./diff-doc -rst -enable-lineno -function 'dup_failed_modules - tracks duplicate failed modules' ./kernel/module/stats.c
+./diff-doc -rst -enable-lineno -function 'eBPF Syscall Commands' ./include/uapi/linux/bpf.h
+./diff-doc -rst -enable-lineno -function 'eBPF Syscall Preamble' ./include/uapi/linux/bpf.h
+./diff-doc -rst -enable-lineno -function ecdh -function crypto_ecdh_key_len -function crypto_ecdh_encode_key -function crypto_ecdh_decode_key ./include/crypto/ecdh.h
+./diff-doc -rst -enable-lineno -function 'ECDH Helper Functions' ./include/crypto/ecdh.h
+./diff-doc -rst -enable-lineno -function efi_embedded_fw_desc ./include/linux/efi_embedded_fw.h
+./diff-doc -rst -enable-lineno -function ethtool_c33_pse_admin_state ./include/uapi/linux/ethtool.h
+./diff-doc -rst -enable-lineno -function ethtool_c33_pse_ext_state ./include/uapi/linux/ethtool.h
+./diff-doc -rst -enable-lineno -function ethtool_c33_pse_ext_substate_class_num_events -function ethtool_c33_pse_ext_substate_error_condition -function ethtool_c33_pse_ext_substate_mr_pse_enable -function ethtool_c33_pse_ext_substate_option_detect_ted -function ethtool_c33_pse_ext_substate_option_vport_lim -function ethtool_c33_pse_ext_substate_ovld_detected -function ethtool_c33_pse_ext_substate_pd_dll_power_type -function ethtool_c33_pse_ext_substate_power_not_available -function ethtool_c33_pse_ext_substate_short_detected ./include/uapi/linux/ethtool.h
+./diff-doc -rst -enable-lineno -function ethtool_c33_pse_pw_d_status ./include/uapi/linux/ethtool.h
+./diff-doc -rst -enable-lineno -function ethtool_fec_stats ./include/linux/ethtool.h
+./diff-doc -rst -enable-lineno -function ethtool_mac_stats_src ./include/uapi/linux/ethtool.h
+./diff-doc -rst -enable-lineno -function ethtool_mm_cfg ./include/linux/ethtool.h
+./diff-doc -rst -enable-lineno -function ethtool_mm_state ./include/linux/ethtool.h
+./diff-doc -rst -enable-lineno -function ethtool_mm_stats ./include/linux/ethtool.h
+./diff-doc -rst -enable-lineno -function ethtool_mm_verify_status ./include/uapi/linux/ethtool.h
+./diff-doc -rst -enable-lineno -function ethtool_module_fw_flash_status ./include/uapi/linux/ethtool.h
+./diff-doc -rst -enable-lineno -function ethtool_module_power_mode ./include/uapi/linux/ethtool.h
+./diff-doc -rst -enable-lineno -function ethtool_module_power_mode_policy ./include/uapi/linux/ethtool.h
+./diff-doc -rst -enable-lineno -function ethtool_pause_stats ./include/linux/ethtool.h
+./diff-doc -rst -enable-lineno -function ethtool_podl_pse_admin_state ./include/uapi/linux/ethtool.h
+./diff-doc -rst -enable-lineno -function ethtool_podl_pse_pw_d_status ./include/uapi/linux/ethtool.h
+./diff-doc -rst -enable-lineno -function EXAMPLE ./drivers/base/auxiliary.c
+./diff-doc -rst -enable-lineno -function Examples ./drivers/gpu/drm/drm_gpuvm.c
+./diff-doc -rst -enable-lineno -function example ./tools/testing/selftests/kselftest_harness.h
+./diff-doc -rst -enable-lineno -function 'Execbuf (User GPU command submission)' ./drivers/gpu/drm/xe/xe_exec.c
+./diff-doc -rst -enable-lineno -function 'explicit fencing properties' ./drivers/gpu/drm/drm_atomic_uapi.c
+./diff-doc -rst -enable-lineno -function extcon_get_property ./drivers/extcon/extcon.c
+./diff-doc -rst -enable-lineno -function extcon_get_state ./drivers/extcon/extcon.c
+./diff-doc -rst -enable-lineno -function extcon_set_state ./drivers/extcon/extcon.c
+./diff-doc -rst -enable-lineno -function extcon_set_state_sync ./drivers/extcon/extcon.c
+./diff-doc -rst -enable-lineno -function fan_curve ./drivers/gpu/drm/amd/pm/amdgpu_pm.c
+./diff-doc -rst -enable-lineno -function fan_minimum_pwm ./drivers/gpu/drm/amd/pm/amdgpu_pm.c
+./diff-doc -rst -enable-lineno -function fan_target_temperature ./drivers/gpu/drm/amd/pm/amdgpu_pm.c
+./diff-doc -rst -enable-lineno -function fan_zero_rpm_enable ./drivers/gpu/drm/amd/pm/amdgpu_pm.c
+./diff-doc -rst -enable-lineno -function fan_zero_rpm_stop_temperature ./drivers/gpu/drm/amd/pm/amdgpu_pm.c
+./diff-doc -rst -enable-lineno -function 'Faraday TV Encoder TVE200 DRM Driver' ./drivers/gpu/drm/tve200/tve200_drv.c
+./diff-doc -rst -enable-lineno -function 'fbdev helpers' ./drivers/gpu/drm/drm_fb_helper.c
+./diff-doc -rst -enable-lineno -function 'fence cross-driver contract' ./drivers/dma-buf/dma-fence.c
+./diff-doc -rst -enable-lineno -function 'fence register handling' ./drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c
+./diff-doc -rst -enable-lineno -function 'fence signalling annotation' ./drivers/dma-buf/dma-fence.c
+./diff-doc -rst -enable-lineno -function fiemap_extent ./include/uapi/linux/fiemap.h
+./diff-doc -rst -enable-lineno -function fiemap_extent_info ./include/linux/fiemap.h
+./diff-doc -rst -enable-lineno -function fiemap ./include/uapi/linux/fiemap.h
+./diff-doc -rst -enable-lineno -function 'fifo underrun handling' ./drivers/gpu/drm/i915/display/intel_fifo_underrun.c
+./diff-doc -rst -enable-lineno -function 'file operations' ./drivers/gpu/drm/drm_file.c
+./diff-doc -rst -enable-lineno -function firmware_fallback_sysfs ./drivers/base/firmware_loader/fallback.c
+./diff-doc -rst -enable-lineno -function 'Firmware Layout' ./drivers/gpu/drm/i915/gt/uc/intel_uc_fw_abi.h
+./diff-doc -rst -enable-lineno -function firmware_request_cache ./drivers/base/firmware_loader/main.c
+./diff-doc -rst -enable-lineno -function firmware_request_nowarn ./drivers/base/firmware_loader/main.c
+./diff-doc -rst -enable-lineno -function firmware_request_platform ./drivers/base/firmware_loader/main.c
+./diff-doc -rst -enable-lineno -function firmware_upload_register ./drivers/base/firmware_loader/sysfs_upload.c
+./diff-doc -rst -enable-lineno -function firmware_upload_unregister ./drivers/base/firmware_loader/sysfs_upload.c
+./diff-doc -rst -enable-lineno -function 'Flags for CREATE_BO' ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function 'Flags for SUBMIT_JOB ioctl compute command.' ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function 'Flags for SUBMIT_JOB ioctl fragment command.' ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function 'Flags for SUBMIT_JOB ioctl geometry command.' ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function 'Flags for SUBMIT_JOB ioctl transfer command.' ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function 'Flags for the drm_pvr_sync_op object.' ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function 'flip utils' ./include/drm/drm_flip_work.h
+./diff-doc -rst -enable-lineno -function 'Flow Control' ./drivers/gpu/drm/scheduler/sched_main.c
+./diff-doc -rst -enable-lineno -function folio_mapping ./mm/util.c
+./diff-doc -rst -enable-lineno -function fpga_bridge_get_to_list ./drivers/fpga/fpga-bridge.c
+./diff-doc -rst -enable-lineno -function fpga_bridge ./include/linux/fpga/fpga-bridge.h
+./diff-doc -rst -enable-lineno -function fpga_bridge_ops ./include/linux/fpga/fpga-bridge.h
+./diff-doc -rst -enable-lineno -function __fpga_bridge_register ./drivers/fpga/fpga-bridge.c
+./diff-doc -rst -enable-lineno -function fpga_bridges_put ./drivers/fpga/fpga-bridge.c
+./diff-doc -rst -enable-lineno -function fpga_bridge_unregister ./drivers/fpga/fpga-bridge.c
+./diff-doc -rst -enable-lineno -function fpga_image_info_alloc ./drivers/fpga/fpga-mgr.c
+./diff-doc -rst -enable-lineno -function fpga_image_info_free ./drivers/fpga/fpga-mgr.c
+./diff-doc -rst -enable-lineno -function fpga_image_info ./include/linux/fpga/fpga-mgr.h
+./diff-doc -rst -enable-lineno -function 'FPGA Manager flags' ./include/linux/fpga/fpga-mgr.h
+./diff-doc -rst -enable-lineno -function fpga_manager ./include/linux/fpga/fpga-mgr.h
+./diff-doc -rst -enable-lineno -function fpga_manager_info ./include/linux/fpga/fpga-mgr.h
+./diff-doc -rst -enable-lineno -function fpga_manager_ops ./include/linux/fpga/fpga-mgr.h
+./diff-doc -rst -enable-lineno -function fpga_mgr_get ./drivers/fpga/fpga-mgr.c
+./diff-doc -rst -enable-lineno -function fpga_mgr_put ./drivers/fpga/fpga-mgr.c
+./diff-doc -rst -enable-lineno -function __fpga_mgr_register ./drivers/fpga/fpga-mgr.c
+./diff-doc -rst -enable-lineno -function __fpga_mgr_register_full ./drivers/fpga/fpga-mgr.c
+./diff-doc -rst -enable-lineno -function fpga_mgr_states ./include/linux/fpga/fpga-mgr.h
+./diff-doc -rst -enable-lineno -function fpga_mgr_unregister ./drivers/fpga/fpga-mgr.c
+./diff-doc -rst -enable-lineno -function fpga_region ./include/linux/fpga/fpga-region.h
+./diff-doc -rst -enable-lineno -function fpga_region_info ./include/linux/fpga/fpga-region.h
+./diff-doc -rst -enable-lineno -function fpga_region_program_fpga ./drivers/fpga/fpga-region.c
+./diff-doc -rst -enable-lineno -function __fpga_region_register ./drivers/fpga/fpga-region.c
+./diff-doc -rst -enable-lineno -function __fpga_region_register_full ./drivers/fpga/fpga-region.c
+./diff-doc -rst -enable-lineno -function fpga_region_unregister ./drivers/fpga/fpga-region.c
+./diff-doc -rst -enable-lineno -function 'Frame Buffer Compression (FBC)' ./drivers/gpu/drm/i915/display/intel_fbc.c
+./diff-doc -rst -enable-lineno -function 'framebuffer dma helper functions' ./drivers/gpu/drm/drm_fb_dma_helper.c
+./diff-doc -rst -enable-lineno -function 'Frame filtering' ./include/net/mac80211.h
+./diff-doc -rst -enable-lineno -function 'Frame format' ./include/net/mac80211.h
+./diff-doc -rst -enable-lineno -function 'frontbuffer tracking' ./drivers/gpu/drm/i915/display/intel_frontbuffer.c
+./diff-doc -rst -enable-lineno -function fru_id ./drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+./diff-doc -rst -enable-lineno -function fs_access -function net_access -function scope ./include/uapi/linux/landlock.h
+./diff-doc -rst -enable-lineno -function fw_iso_context_schedule_flush_completions ./include/linux/firewire.h
+./diff-doc -rst -enable-lineno -function fw_upload_err ./include/linux/firmware.h
+./diff-doc -rst -enable-lineno -function fw_upload_ops ./include/linux/firmware.h
+./diff-doc -rst -enable-lineno -function fw_upload_prog ./drivers/base/firmware_loader/sysfs_upload.h
+./diff-doc -rst -enable-lineno -function 'Generic Key-agreement Protocol Primitives API' ./include/crypto/kpp.h
+./diff-doc -rst -enable-lineno -function 'Generic Public Key Cipher API' ./include/crypto/akcipher.h
+./diff-doc -rst -enable-lineno -function 'Generic Public Key Signature API' ./include/crypto/sig.h
+./diff-doc -rst -enable-lineno -function 'Generic radix trees/sparse arrays' ./include/linux/generic-radix-tree.h
+./diff-doc -rst -enable-lineno -function gen_pool_add ./include/linux/genalloc.h
+./diff-doc -rst -enable-lineno -function gen_pool_add_owner ./lib/genalloc.c
+./diff-doc -rst -enable-lineno -function gen_pool_alloc_algo_owner ./lib/genalloc.c
+./diff-doc -rst -enable-lineno -function gen_pool_alloc ./include/linux/genalloc.h
+./diff-doc -rst -enable-lineno -function gen_pool_avail ./lib/genalloc.c
+./diff-doc -rst -enable-lineno -function gen_pool_create ./lib/genalloc.c
+./diff-doc -rst -enable-lineno -function gen_pool_destroy ./lib/genalloc.c
+./diff-doc -rst -enable-lineno -function gen_pool_dma_alloc ./lib/genalloc.c
+./diff-doc -rst -enable-lineno -function gen_pool_for_each_chunk ./lib/genalloc.c
+./diff-doc -rst -enable-lineno -function gen_pool_free_owner ./lib/genalloc.c
+./diff-doc -rst -enable-lineno -function gen_pool_get ./lib/genalloc.c
+./diff-doc -rst -enable-lineno -function gen_pool_has_addr ./lib/genalloc.c
+./diff-doc -rst -enable-lineno -function gen_pool_set_algo ./lib/genalloc.c
+./diff-doc -rst -enable-lineno -function gen_pool_size ./lib/genalloc.c
+./diff-doc -rst -enable-lineno -function gen_pool_virt_to_phys ./lib/genalloc.c
+./diff-doc -rst -enable-lineno -function 'getunique and setversion story' ./drivers/gpu/drm/drm_ioctl.c
+./diff-doc -rst -enable-lineno -function get_user_pages_fast ./mm/gup.c
+./diff-doc -rst -enable-lineno -function 'Global Graphics Translation Table (GGTT)' ./drivers/gpu/drm/xe/xe_ggtt.c
+./diff-doc -rst -enable-lineno -function 'Global GTT views' ./drivers/gpu/drm/i915/i915_vma_types.h
+./diff-doc -rst -enable-lineno -function gpioevent_data -function gpioevent_request -function gpiohandle_config -function gpiohandle_data -function gpiohandle_request -function gpioline_info -function gpioline_info_changed ./include/uapi/linux/gpio.h
+./diff-doc -rst -enable-lineno -function gpio_v2_line_attr_id -function gpio_v2_line_attribute -function gpio_v2_line_changed_type -function gpio_v2_line_config -function gpio_v2_line_config_attribute -function gpio_v2_line_event -function gpio_v2_line_event_id -function gpio_v2_line_flag -function gpio_v2_line_info -function gpio_v2_line_info_changed -function gpio_v2_line_request -function gpio_v2_line_values -function gpiochip_info ./include/uapi/linux/gpio.h
+./diff-doc -rst -enable-lineno -function gpu_busy_percent ./drivers/gpu/drm/amd/pm/amdgpu_pm.c
+./diff-doc -rst -enable-lineno -function gpu_metrics ./drivers/gpu/drm/amd/pm/amdgpu_pm.c
+./diff-doc -rst -enable-lineno -function GPUVM ./drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+./diff-doc -rst -enable-lineno -function 'Graphics mux' ./drivers/platform/x86/apple-gmux.c
+./diff-doc -rst -enable-lineno -function 'GSC-based Firmware Layout' ./drivers/gpu/drm/xe/xe_uc_fw_abi.h
+./diff-doc -rst -enable-lineno -function 'GT Multicast/Replicated (MCR) Register Support' ./drivers/gpu/drm/i915/gt/intel_gt_mcr.c
+./diff-doc -rst -enable-lineno -function 'GT Multicast/Replicated (MCR) Register Support' ./drivers/gpu/drm/xe/xe_gt_mcr.c
+./diff-doc -rst -enable-lineno -function 'GuC-based command submission' ./drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
+./diff-doc -rst -enable-lineno -function 'GuC CTB Blob' ./drivers/gpu/drm/xe/xe_guc_ct.c
+./diff-doc -rst -enable-lineno -function GuC ./drivers/gpu/drm/i915/gt/uc/intel_guc.c
+./diff-doc -rst -enable-lineno -function 'GuC Memory Management' ./drivers/gpu/drm/i915/gt/uc/intel_guc.c
+./diff-doc -rst -enable-lineno -function 'GuC Power Conservation (PC)' ./drivers/gpu/drm/xe/xe_guc_pc.c
+./diff-doc -rst -enable-lineno -function 'handling driver private state' ./drivers/gpu/drm/drm_atomic.c
+./diff-doc -rst -enable-lineno -function 'Hardware crypto acceleration' ./include/net/mac80211.h
+./diff-doc -rst -enable-lineno -function 'Hardware workarounds' ./drivers/gpu/drm/i915/gt/intel_workarounds.c
+./diff-doc -rst -enable-lineno -function 'Hardware workarounds' ./drivers/gpu/drm/xe/xe_wa.c
+./diff-doc -rst -enable-lineno -function hash_alg_common -function ahash_alg -function shash_alg ./include/crypto/hash.h
+./diff-doc -rst -enable-lineno -function 'HDMI connector properties' ./drivers/gpu/drm/drm_connector.c
+./diff-doc -rst -enable-lineno -function 'HDMI Output' ./drivers/gpu/drm/meson/meson_dw_hdmi.c
+./diff-doc -rst -enable-lineno -function hid_bpf_ctx ./include/linux/hid_bpf.h
+./diff-doc -rst -enable-lineno -function hid_bpf_get_data ./drivers/hid/bpf/hid_bpf_dispatch.c
+./diff-doc -rst -enable-lineno -function hid_bpf_hw_request -function hid_bpf_hw_output_report -function hid_bpf_input_report -function hid_bpf_try_input_report -function hid_bpf_allocate_context -function hid_bpf_release_context ./drivers/hid/bpf/hid_bpf_dispatch.c
+./diff-doc -rst -enable-lineno -function hid_bpf_ops ./include/linux/hid_bpf.h
+./diff-doc -rst -enable-lineno -function 'HID quirks' ./include/linux/hid.h
+./diff-doc -rst -enable-lineno -function 'High Definition Audio over HDMI and Display Port' ./drivers/gpu/drm/i915/display/intel_audio.c
+./diff-doc -rst -enable-lineno -function Hotplug ./drivers/gpu/drm/i915/display/intel_hotplug.c
+./diff-doc -rst -enable-lineno -function 'hotspot properties' ./drivers/gpu/drm/drm_plane.c
+./diff-doc -rst -enable-lineno -function hte_init_line_attr -function hte_ts_get -function hte_ts_put -function devm_hte_request_ts_ns -function hte_request_ts_ns -function hte_enable_ts -function hte_disable_ts -function of_hte_req_count -function hte_get_clk_src_info ./drivers/hte/hte.c
+./diff-doc -rst -enable-lineno -function HuC ./drivers/gpu/drm/i915/gt/uc/intel_huc.c
+./diff-doc -rst -enable-lineno -function 'HuC Memory Management' ./drivers/gpu/drm/i915/gt/uc/intel_huc.c
+./diff-doc -rst -enable-lineno -function hwmon ./drivers/gpu/drm/amd/pm/amdgpu_pm.c
+./diff-doc -rst -enable-lineno -function i2c_register_board_info ./drivers/i2c/i2c-boardinfo.c
+./diff-doc -rst -enable-lineno -function 'i915_context_create and i915_context_free tracepoints' ./drivers/gpu/drm/i915/i915_trace.h
+./diff-doc -rst -enable-lineno -function i915_context_engines_parallel_submit ./include/uapi/drm/i915_drm.h
+./diff-doc -rst -enable-lineno -function i915_oa_ops ./drivers/gpu/drm/i915/i915_perf_types.h
+./diff-doc -rst -enable-lineno -function i915_oa_poll_wait ./drivers/gpu/drm/i915/i915_perf.c
+./diff-doc -rst -enable-lineno -function i915_oa_read ./drivers/gpu/drm/i915/i915_perf.c
+./diff-doc -rst -enable-lineno -function i915_oa_stream_disable ./drivers/gpu/drm/i915/i915_perf.c
+./diff-doc -rst -enable-lineno -function i915_oa_stream_enable ./drivers/gpu/drm/i915/i915_perf.c
+./diff-doc -rst -enable-lineno -function i915_oa_stream_init ./drivers/gpu/drm/i915/i915_perf.c
+./diff-doc -rst -enable-lineno -function i915_oa_wait_unlocked ./drivers/gpu/drm/i915/i915_perf.c
+./diff-doc -rst -enable-lineno -function i915_perf_add_config_ioctl ./drivers/gpu/drm/i915/i915_perf.c
+./diff-doc -rst -enable-lineno -function i915_perf_destroy_locked ./drivers/gpu/drm/i915/i915_perf.c
+./diff-doc -rst -enable-lineno -function i915_perf_disable_locked ./drivers/gpu/drm/i915/i915_perf.c
+./diff-doc -rst -enable-lineno -function i915_perf_enable_locked ./drivers/gpu/drm/i915/i915_perf.c
+./diff-doc -rst -enable-lineno -function i915_perf_fini ./drivers/gpu/drm/i915/i915_perf.c
+./diff-doc -rst -enable-lineno -function 'i915 Perf History and Comparison with Core Perf' ./drivers/gpu/drm/i915/i915_perf.c
+./diff-doc -rst -enable-lineno -function i915_perf_init ./drivers/gpu/drm/i915/i915_perf.c
+./diff-doc -rst -enable-lineno -function i915_perf_ioctl ./drivers/gpu/drm/i915/i915_perf.c
+./diff-doc -rst -enable-lineno -function i915_perf_open_ioctl ./drivers/gpu/drm/i915/i915_perf.c
+./diff-doc -rst -enable-lineno -function i915_perf_open_ioctl_locked ./drivers/gpu/drm/i915/i915_perf.c
+./diff-doc -rst -enable-lineno -function 'i915 Perf Overview' ./drivers/gpu/drm/i915/i915_perf.c
+./diff-doc -rst -enable-lineno -function i915_perf_poll ./drivers/gpu/drm/i915/i915_perf.c
+./diff-doc -rst -enable-lineno -function i915_perf_poll_locked ./drivers/gpu/drm/i915/i915_perf.c
+./diff-doc -rst -enable-lineno -function i915_perf_read ./drivers/gpu/drm/i915/i915_perf.c
+./diff-doc -rst -enable-lineno -function i915_perf_register ./drivers/gpu/drm/i915/i915_perf.c
+./diff-doc -rst -enable-lineno -function i915_perf_release ./drivers/gpu/drm/i915/i915_perf.c
+./diff-doc -rst -enable-lineno -function i915_perf_remove_config_ioctl ./drivers/gpu/drm/i915/i915_perf.c
+./diff-doc -rst -enable-lineno -function i915_perf_stream ./drivers/gpu/drm/i915/i915_perf_types.h
+./diff-doc -rst -enable-lineno -function i915_perf_stream_ops ./drivers/gpu/drm/i915/i915_perf_types.h
+./diff-doc -rst -enable-lineno -function i915_perf_unregister ./drivers/gpu/drm/i915/i915_perf.c
+./diff-doc -rst -enable-lineno -function 'i915_ppgtt_create and i915_ppgtt_release tracepoints' ./drivers/gpu/drm/i915/i915_trace.h
+./diff-doc -rst -enable-lineno -function i915_sched_engine ./drivers/gpu/drm/i915/i915_scheduler_types.h
+./diff-doc -rst -enable-lineno -function 'IDA description' ./lib/idr.c
+./diff-doc -rst -enable-lineno -function 'idr sync' ./include/linux/idr.h
+./diff-doc -rst -enable-lineno -function ieee80211_ampdu_mlme_action ./include/net/mac80211.h
+./diff-doc -rst -enable-lineno -function ieee80211_beacon_loss ./include/net/mac80211.h
+./diff-doc -rst -enable-lineno -function ieee80211_channel_flags -function ieee80211_channel -function ieee80211_rate_flags -function ieee80211_rate -function ieee80211_sta_ht_cap -function ieee80211_supported_band -function cfg80211_signal_type -function wiphy_params_flags -function wiphy_flags -function wiphy -function wireless_dev -function wiphy_new -function wiphy_read_of_freq_limits -function wiphy_register -function wiphy_unregister -function wiphy_free -function wiphy_name -function wiphy_dev -function wiphy_priv -function priv_to_wiphy -function set_wiphy_dev -function wdev_priv -function ieee80211_iface_limit -function ieee80211_iface_combination -function cfg80211_check_combinations ./include/net/cfg80211.h
+./diff-doc -rst -enable-lineno -function ieee80211_channel_to_frequency -function ieee80211_frequency_to_channel -function ieee80211_get_channel -function ieee80211_get_response_rate -function ieee80211_hdrlen -function ieee80211_get_hdrlen_from_skb -function ieee80211_radiotap_iterator ./include/net/cfg80211.h
+./diff-doc -rst -enable-lineno -function ieee80211_conf -function ieee80211_conf_flags ./include/net/mac80211.h
+./diff-doc -rst -enable-lineno -function ieee80211_data_to_8023 -function ieee80211_amsdu_to_8023s -function cfg80211_classify8021d ./include/net/cfg80211.h
+./diff-doc -rst -enable-lineno -function ieee80211_filter_flags ./include/net/mac80211.h
+./diff-doc -rst -enable-lineno -function ieee80211_get_buffered_bc -function ieee80211_beacon_get -function ieee80211_sta_eosp -function ieee80211_frame_release_type -function ieee80211_sta_ps_transition -function ieee80211_sta_ps_transition_ni -function ieee80211_sta_set_buffered -function ieee80211_sta_block_awake ./include/net/mac80211.h
+./diff-doc -rst -enable-lineno -function ieee80211_get_tx_led_name -function ieee80211_get_rx_led_name -function ieee80211_get_assoc_led_name -function ieee80211_get_radio_led_name -function ieee80211_tpt_blink -function ieee80211_tpt_led_trigger_flags -function ieee80211_create_tpt_led_trigger ./include/net/mac80211.h
+./diff-doc -rst -enable-lineno -function ieee80211_hw -function ieee80211_hw_flags -function SET_IEEE80211_DEV -function SET_IEEE80211_PERM_ADDR -function ieee80211_ops -function ieee80211_alloc_hw -function ieee80211_register_hw -function ieee80211_unregister_hw -function ieee80211_free_hw ./include/net/mac80211.h
+./diff-doc -rst -enable-lineno -function ieee80211_iterate_active_interfaces -function ieee80211_iterate_active_interfaces_atomic ./include/net/mac80211.h
+./diff-doc -rst -enable-lineno -function ieee80211_queue_work -function ieee80211_queue_delayed_work ./include/net/mac80211.h
+./diff-doc -rst -enable-lineno -function ieee80211_request_smps -function ieee80211_smps_mode ./include/net/mac80211.h
+./diff-doc -rst -enable-lineno -function ieee80211_rx_status -function mac80211_rx_encoding_flags -function mac80211_rx_flags -function mac80211_tx_info_flags -function mac80211_tx_control_flags -function mac80211_rate_control_flags -function ieee80211_tx_rate -function ieee80211_tx_info -function ieee80211_tx_info_clear_status -function ieee80211_rx -function ieee80211_rx_ni -function ieee80211_rx_irqsafe -function ieee80211_tx_status_skb -function ieee80211_tx_status_ni -function ieee80211_tx_status_irqsafe -function ieee80211_rts_get -function ieee80211_rts_duration -function ieee80211_ctstoself_get -function ieee80211_ctstoself_duration -function ieee80211_generic_frame_duration -function ieee80211_wake_queue -function ieee80211_stop_queue -function ieee80211_wake_queues -function ieee80211_stop_queues -function ieee80211_queue_stopped ./include/net/mac80211.h
+./diff-doc -rst -enable-lineno -function ieee80211_scan_completed ./include/net/mac80211.h
+./diff-doc -rst -enable-lineno -function ieee80211_sta -function sta_notify_cmd -function ieee80211_find_sta -function ieee80211_find_sta_by_ifaddr ./include/net/mac80211.h
+./diff-doc -rst -enable-lineno -function ieee80211_start_tx_ba_session -function ieee80211_start_tx_ba_cb_irqsafe -function ieee80211_stop_tx_ba_session -function ieee80211_stop_tx_ba_cb_irqsafe -function ieee80211_rate_control_changed -function ieee80211_tx_rate_control ./include/net/mac80211.h
+./diff-doc -rst -enable-lineno -function ieee80211_tx_queue_params ./include/net/mac80211.h
+./diff-doc -rst -enable-lineno -function ieee80211_vif ./include/net/mac80211.h
+./diff-doc -rst -enable-lineno -function 'implementing nonblocking commit' ./drivers/gpu/drm/drm_atomic_helper.c
+./diff-doc -rst -enable-lineno -function 'implicit fence polling' ./drivers/dma-buf/dma-buf.c
+./diff-doc -rst -enable-lineno -function intel_guc_allocate_vma ./drivers/gpu/drm/i915/gt/uc/intel_guc.c
+./diff-doc -rst -enable-lineno -function 'Intel GVT-g guest support' ./drivers/gpu/drm/i915/i915_vgpu.c
+./diff-doc -rst -enable-lineno -function 'Intel GVT-g host support' ./drivers/gpu/drm/i915/intel_gvt.c
+./diff-doc -rst -enable-lineno -function intel_huc_auth ./drivers/gpu/drm/i915/gt/uc/intel_huc.c
+./diff-doc -rst -enable-lineno -function intel_irq_init -function intel_irq_init_hw -function intel_hpd_init ./drivers/gpu/drm/i915/i915_irq.c
+./diff-doc -rst -enable-lineno -function intel_irq_resume ./drivers/gpu/drm/i915/i915_irq.c
+./diff-doc -rst -enable-lineno -function intel_irq_suspend ./drivers/gpu/drm/i915/i915_irq.c
+./diff-doc -rst -enable-lineno -function Interrupt ./drivers/platform/x86/apple-gmux.c
+./diff-doc -rst -enable-lineno -function 'Interrupt Handling' ./drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+./diff-doc -rst -enable-lineno -function 'interrupt handling' ./drivers/gpu/drm/i915/i915_irq.c
+./diff-doc -rst -enable-lineno -function 'Interrupt management for the V3D engine' ./drivers/gpu/drm/v3d/v3d_irq.c
+./diff-doc -rst -enable-lineno -function 'Interrupt management for the V3D engine' ./drivers/gpu/drm/vc4/vc4_irq.c
+./diff-doc -rst -enable-lineno -function Introduction ./include/net/cfg80211.h
+./diff-doc -rst -enable-lineno -function 'IOCTL validation helpers' ./drivers/gpu/drm/imagination/pvr_device.h
+./diff-doc -rst -enable-lineno -function 'IP Blocks' ./drivers/gpu/drm/amd/include/amd_shared.h
+./diff-doc -rst -enable-lineno -function iscsi_iser_pdu_alloc -function iser_initialize_task_headers -function \ -function iscsi_iser_task_init -function iscsi_iser_mtask_xmit -function iscsi_iser_task_xmit -function \ -function iscsi_iser_cleanup_task -function iscsi_iser_check_protection -function \ -function iscsi_iser_conn_create -function iscsi_iser_conn_bind -function \ -function iscsi_iser_conn_start -function iscsi_iser_conn_stop -function \ -function iscsi_iser_session_destroy -function iscsi_iser_session_create -function \ -function iscsi_iser_set_param -function iscsi_iser_ep_connect -function iscsi_iser_ep_poll -function \ -function iscsi_iser_ep_disconnect ./drivers/infiniband/ulp/iser/iscsi_iser.c
+./diff-doc -rst -enable-lineno -function is_kfence_address -function kfence_shutdown_cache -function kfence_alloc -function kfence_free -function __kfence_free -function kfence_ksize -function kfence_object_start -function kfence_handle_page_fault ./include/linux/kfence.h
+./diff-doc -rst -enable-lineno -function kernel_hwtstamp_config ./include/linux/net_tstamp.h
+./diff-doc -rst -enable-lineno -function 'Key handling basics' ./net/mac80211/key.c
+./diff-doc -rst -enable-lineno -function kfree_const -function kvmalloc_node -function kvfree ./mm/util.c
+./diff-doc -rst -enable-lineno -function klp_patch -function klp_object -function klp_func -function klp_callbacks -function klp_state ./include/linux/livepatch.h
+./diff-doc -rst -enable-lineno -function 'kms locking' ./drivers/gpu/drm/drm_modeset_lock.c
+./diff-doc -rst -enable-lineno -function kpp_request_alloc -function kpp_request_free -function kpp_request_set_callback -function kpp_request_set_input -function kpp_request_set_output ./include/crypto/kpp.h
+./diff-doc -rst -enable-lineno -function kpp_request -function crypto_kpp -function kpp_alg -function kpp_secret ./include/crypto/kpp.h
+./diff-doc -rst -enable-lineno -function kstrdup -function kstrdup_const -function kstrndup -function kmemdup -function kmemdup_nul -function memdup_user -function vmemdup_user -function strndup_user -function memdup_user_nul ./mm/util.c
+./diff-doc -rst -enable-lineno -function kstrtol -function kstrtoul ./include/linux/kstrtox.h
+./diff-doc -rst -enable-lineno -function landlock_ruleset_attr ./include/uapi/linux/landlock.h
+./diff-doc -rst -enable-lineno -function landlock_rule_type -function landlock_path_beneath_attr -function landlock_net_port_attr ./include/uapi/linux/landlock.h
+./diff-doc -rst -enable-lineno -function lirc_scancode -function rc_proto ./include/uapi/linux/lirc.h
+./diff-doc -rst -enable-lineno -function 'locking convention' ./drivers/dma-buf/dma-buf.c
+./diff-doc -rst -enable-lineno -function Locking ./drivers/gpu/drm/drm_gpuvm.c
+./diff-doc -rst -enable-lineno -function 'Lockless queue stopping / waking helpers.' ./include/net/netdev_queues.h
+./diff-doc -rst -enable-lineno -function 'Logical Rings, Logical Ring Contexts and Execlists' ./drivers/gpu/drm/i915/gt/intel_execlists_submission.c
+./diff-doc -rst -enable-lineno -function 'LPE Audio integration for HDMI or DP playback' ./drivers/gpu/drm/i915/display/intel_lpe_audio.c
+./diff-doc -rst -enable-lineno -function 'lru scan roster' ./drivers/gpu/drm/drm_mm.c
+./diff-doc -rst -enable-lineno -function 'mac80211 workqueue' ./include/net/mac80211.h
+./diff-doc -rst -enable-lineno -function 'managed resources' ./drivers/gpu/drm/drm_managed.c
+./diff-doc -rst -enable-lineno -function 'Manual switching and manual power control' ./drivers/gpu/vga/vga_switcheroo.c
+./diff-doc -rst -enable-lineno -function manufacturer ./drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+./diff-doc -rst -enable-lineno -function 'Map layer' ./drivers/gpu/drm/xe/xe_map.h
+./diff-doc -rst -enable-lineno -function 'master and authentication' ./drivers/gpu/drm/drm_auth.c
+./diff-doc -rst -enable-lineno -function mctrl_gpio_init -function mctrl_gpio_free -function mctrl_gpio_to_gpiod -function mctrl_gpio_set -function mctrl_gpio_get -function mctrl_gpio_enable_ms -function mctrl_gpio_disable_ms ./drivers/tty/serial/serial_mctrl_gpio.c
+./diff-doc -rst -enable-lineno -function mdelay ./include/linux/delay.h
+./diff-doc -rst -enable-lineno -function 'MEI_HDCP Client Driver' ./drivers/misc/mei/hdcp/mei_hdcp.c
+./diff-doc -rst -enable-lineno -function memalloc_nofs_save -function memalloc_nofs_restore ./include/linux/sched/mm.h
+./diff-doc -rst -enable-lineno -function memalloc_noio_save -function memalloc_noio_restore ./include/linux/sched/mm.h
+./diff-doc -rst -enable-lineno -function 'memblock overview' ./mm/memblock.c
+./diff-doc -rst -enable-lineno -function mem_busy_percent ./drivers/gpu/drm/amd/pm/amdgpu_pm.c
+./diff-doc -rst -enable-lineno -function mem_info_gtt_total ./drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+./diff-doc -rst -enable-lineno -function mem_info_gtt_used ./drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+./diff-doc -rst -enable-lineno -function mem_info_vis_vram_total ./drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+./diff-doc -rst -enable-lineno -function mem_info_vis_vram_used ./drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+./diff-doc -rst -enable-lineno -function mem_info_vram_total ./drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+./diff-doc -rst -enable-lineno -function mem_info_vram_used ./drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+./diff-doc -rst -enable-lineno -function 'memory domains' ./include/uapi/drm/amdgpu_drm.h
+./diff-doc -rst -enable-lineno -function 'Message Digest Algorithm Definitions' ./include/crypto/hash.h
+./diff-doc -rst -enable-lineno -function 'Migrate Layer' ./drivers/gpu/drm/xe/xe_migrate_doc.h
+./diff-doc -rst -enable-lineno -function mm_slot -function ksm_scan -function stable_node -function rmap_item ./mm/ksm.c
+./diff-doc -rst -enable-lineno -function 'MMU Notifier' ./drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+./diff-doc -rst -enable-lineno -function 'module debugging statistics overview' ./kernel/module/stats.c
+./diff-doc -rst -enable-lineno -function 'module statistics debugfs counters' ./kernel/module/stats.c
+./diff-doc -rst -enable-lineno -function mpcc_alpha_blend_mode ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+./diff-doc -rst -enable-lineno -function mpcc_blnd_cfg ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+./diff-doc -rst -enable-lineno -function msleep -function msleep_interruptible ./kernel/time/sleep_timeout.c
+./diff-doc -rst -enable-lineno -function 'Multi-tile Design' ./drivers/gpu/drm/xe/xe_tile.c
+./diff-doc -rst -enable-lineno -function nbcon_state -function nbcon_prio -function nbcon_context -function nbcon_write_context ./include/linux/console.h
+./diff-doc -rst -enable-lineno -function net_bridge_vlan ./net/bridge/br_private.h
+./diff-doc -rst -enable-lineno -function of_fpga_bridge_get_to_list ./drivers/fpga/fpga-bridge.c
+./diff-doc -rst -enable-lineno -function of_fpga_mgr_get ./drivers/fpga/fpga-mgr.c
+./diff-doc -rst -enable-lineno -function of_gen_pool_get ./lib/genalloc.c
+./diff-doc -rst -enable-lineno -function of_reset_simple_xlate -function reset_controller_register -function reset_controller_unregister -function devm_reset_controller_register -function reset_controller_add_lookup ./drivers/reset/core.c
+./diff-doc -rst -enable-lineno -function operators ./tools/testing/selftests/kselftest_harness.h
+./diff-doc -rst -enable-lineno -function 'output probing helper overview' ./drivers/gpu/drm/drm_probe_helper.c
+./diff-doc -rst -enable-lineno -function 'overview and lifetime rules' ./drivers/gpu/drm/drm_prime.c
+./diff-doc -rst -enable-lineno -function overview ./arch/x86/kernel/cpu/intel_epb.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/base/component.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/dma-buf/dma-buf-sysfs-stats.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/display/drm_bridge_connector.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/drm_atomic_helper.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/drm_atomic_uapi.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/drm_blend.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/drm_bridge.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/drm_client.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/drm_color_mgmt.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/drm_connector.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/drm_crtc.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/drm_crtc_helper.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/drm_dumb_buffers.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/drm_encoder.c
+./diff-doc -rst -enable-lineno -function Overview ./drivers/gpu/drm/drm_exec.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/drm_framebuffer.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/drm_gem_atomic_helper.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/drm_gem_framebuffer_helper.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/drm_gem_shmem_helper.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/drm_gem_ttm_helper.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/drm_gem_vram_helper.c
+./diff-doc -rst -enable-lineno -function Overview ./drivers/gpu/drm/drm_gpuvm.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/drm_mipi_dbi.c
+./diff-doc -rst -enable-lineno -function Overview ./drivers/gpu/drm/drm_mm.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/drm_of.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/drm_panic.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/drm_plane.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/drm_plane_helper.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/drm_privacy_screen.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/drm_property.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/drm_self_refresh_helper.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/drm_simple_kms_helper.c
+./diff-doc -rst -enable-lineno -function Overview ./drivers/gpu/drm/drm_syncobj.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/drm_sysfs.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/gpu/drm/drm_writeback.c
+./diff-doc -rst -enable-lineno -function Overview ./drivers/gpu/drm/nouveau/nouveau_exec.c
+./diff-doc -rst -enable-lineno -function Overview ./drivers/gpu/drm/scheduler/sched_main.c
+./diff-doc -rst -enable-lineno -function Overview ./drivers/gpu/vga/vga_switcheroo.c
+./diff-doc -rst -enable-lineno -function Overview ./drivers/platform/x86/apple-gmux.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/video/aperture.c
+./diff-doc -rst -enable-lineno -function overview ./drivers/video/backlight/backlight.c
+./diff-doc -rst -enable-lineno -function overview ./include/drm/drm_modeset_helper_vtables.h
+./diff-doc -rst -enable-lineno -function overview ./include/drm/drm_module.h
+./diff-doc -rst -enable-lineno -function overview ./include/linux/iosys-map.h
+./diff-doc -rst -enable-lineno -function overview ./include/uapi/drm/drm_fourcc.h
+./diff-doc -rst -enable-lineno -function overview ./include/uapi/drm/drm_mode.h
+./diff-doc -rst -enable-lineno -function Overview ./mm/ksm.c
+./diff-doc -rst -enable-lineno -function 'Packet alignment' ./net/mac80211/rx.c
+./diff-doc -rst -enable-lineno -function 'Page mobility and placement hints' ./include/linux/gfp_types.h
+./diff-doc -rst -enable-lineno -function 'page_pool allocator' ./include/net/page_pool/helpers.h
+./diff-doc -rst -enable-lineno -function page_pool_create ./net/core/page_pool.c
+./diff-doc -rst -enable-lineno -function page_pool_put_page_bulk -function page_pool_get_stats ./net/core/page_pool.c
+./diff-doc -rst -enable-lineno -function page_pool_put_page -function page_pool_put_full_page -function page_pool_recycle_direct -function page_pool_free_va -function page_pool_dev_alloc_pages -function page_pool_dev_alloc_frag -function page_pool_dev_alloc -function page_pool_dev_alloc_va -function page_pool_get_dma_addr -function page_pool_get_dma_dir ./include/net/page_pool/helpers.h
+./diff-doc -rst -enable-lineno -function 'Pagetable building' ./drivers/gpu/drm/xe/xe_pt.c
+./diff-doc -rst -enable-lineno -function 'Panel Self Refresh (PSR/SRD)' ./drivers/gpu/drm/i915/display/intel_psr.c
+./diff-doc -rst -enable-lineno -function pci_device_id ./include/linux/mod_devicetable.h
+./diff-doc -rst -enable-lineno -function pci_driver ./include/linux/pci.h
+./diff-doc -rst -enable-lineno -function pcie_bw ./drivers/gpu/drm/amd/pm/amdgpu_pm.c
+./diff-doc -rst -enable-lineno -function pcie_replay_count ./drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+./diff-doc -rst -enable-lineno -function PCODE ./drivers/gpu/drm/xe/xe_pcode.c
+./diff-doc -rst -enable-lineno -function pm_policy ./drivers/gpu/drm/amd/pm/amdgpu_pm.c
+./diff-doc -rst -enable-lineno -function 'Power control' ./drivers/platform/x86/apple-gmux.c
+./diff-doc -rst -enable-lineno -function power_dpm_force_performance_level ./drivers/gpu/drm/amd/pm/amdgpu_pm.c
+./diff-doc -rst -enable-lineno -function power_dpm_state ./drivers/gpu/drm/amd/pm/amdgpu_pm.c
+./diff-doc -rst -enable-lineno -function 'Powersave support' ./include/net/mac80211.h
+./diff-doc -rst -enable-lineno -function 'PowerVR IOCTL CREATE_BO interface' ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function 'PowerVR IOCTL CREATE_CONTEXT and DESTROY_CONTEXT interfaces' ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function 'PowerVR IOCTL CREATE_FREE_LIST and DESTROY_FREE_LIST interfaces' ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function 'PowerVR IOCTL CREATE_HWRT_DATASET and DESTROY_HWRT_DATASET interfaces' ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function 'PowerVR IOCTL CREATE_VM_CONTEXT and DESTROY_VM_CONTEXT interfaces' ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function 'PowerVR IOCTL DEV_QUERY interface' ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function 'PowerVR IOCTL GET_BO_MMAP_OFFSET interface' ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function 'PowerVR IOCTL interface' ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function 'PowerVR IOCTL SUBMIT_JOBS interface' ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function 'PowerVR IOCTL VM_MAP and VM_UNMAP interfaces' ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function 'PowerVR (Series 6 and later) and IMG Graphics Driver' ./drivers/gpu/drm/imagination/pvr_drv.c
+./diff-doc -rst -enable-lineno -function 'PowerVR UAPI' ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function 'pp_dpm_sclk pp_dpm_mclk pp_dpm_socclk pp_dpm_fclk pp_dpm_dcefclk pp_dpm_pcie' ./drivers/gpu/drm/amd/pm/amdgpu_pm.c
+./diff-doc -rst -enable-lineno -function pp_od_clk_voltage ./drivers/gpu/drm/amd/pm/amdgpu_pm.c
+./diff-doc -rst -enable-lineno -function pp_power_profile_mode ./drivers/gpu/drm/amd/pm/amdgpu_pm.c
+./diff-doc -rst -enable-lineno -function pp_table ./drivers/gpu/drm/amd/pm/amdgpu_pm.c
+./diff-doc -rst -enable-lineno -function 'PRIME Buffer Sharing' ./drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+./diff-doc -rst -enable-lineno -function 'PRIME Helpers' ./drivers/gpu/drm/drm_prime.c
+./diff-doc -rst -enable-lineno -function print ./include/drm/drm_print.h
+./diff-doc -rst -enable-lineno -function printk -function pr_emerg -function pr_alert -function pr_crit -function pr_err -function pr_warn -function pr_notice -function pr_info -function pr_fmt -function pr_debug -function pr_devel -function pr_cont ./include/linux/printk.h
+./diff-doc -rst -enable-lineno -function probe_type -function device_driver ./include/linux/device/driver.h
+./diff-doc -rst -enable-lineno -function product_name ./drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+./diff-doc -rst -enable-lineno -function product_number ./drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+./diff-doc -rst -enable-lineno -function PURPOSE ./drivers/base/auxiliary.c
+./diff-doc -rst -enable-lineno -function PVR_IOCTL ./include/uapi/drm/pvr_drm.h
+./diff-doc -rst -enable-lineno -function PVR_STATIC_ASSERT_64BIT_ALIGNED -function PVR_IOCTL_UNION_PADDING_CHECK -function pvr_ioctl_union_padding_check ./drivers/gpu/drm/imagination/pvr_device.h
+./diff-doc -rst -enable-lineno -function PXP ./drivers/gpu/drm/i915/pxp/intel_pxp.c
+./diff-doc -rst -enable-lineno -function 'Random number generator API' ./include/crypto/rng.h
+./diff-doc -rst -enable-lineno -function 'Readahead Overview' ./mm/readahead.c
+./diff-doc -rst -enable-lineno -function read_properties_unlocked ./drivers/gpu/drm/i915/i915_perf.c
+./diff-doc -rst -enable-lineno -function 'Reclaim modifiers' ./include/linux/gfp_types.h
+./diff-doc -rst -enable-lineno -function 'rect utils' ./include/drm/drm_rect.h
+./diff-doc -rst -enable-lineno -function register_hpd_handlers -function dm_crtc_high_irq -function dm_pflip_high_irq ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+./diff-doc -rst -enable-lineno -function 'Register Table Processing' ./drivers/gpu/drm/xe/xe_rtp.c
+./diff-doc -rst -enable-lineno -function 'Regulatory enforcement infrastructure' ./include/net/cfg80211.h
+./diff-doc -rst -enable-lineno -function regulatory_hint -function wiphy_apply_custom_regulatory -function freq_reg_info ./include/net/cfg80211.h
+./diff-doc -rst -enable-lineno -function 'Render command list generation' ./drivers/gpu/drm/vc4/vc4_render_cl.c
+./diff-doc -rst -enable-lineno -function request_firmware_direct ./drivers/base/firmware_loader/main.c
+./diff-doc -rst -enable-lineno -function request_firmware ./drivers/base/firmware_loader/main.c
+./diff-doc -rst -enable-lineno -function request_firmware_into_buf ./drivers/base/firmware_loader/main.c
+./diff-doc -rst -enable-lineno -function request_firmware_nowait ./drivers/base/firmware_loader/main.c
+./diff-doc -rst -enable-lineno -function 'Reservation Object Overview' ./drivers/dma-buf/dma-resv.c
+./diff-doc -rst -enable-lineno -function reset_control_reset -function reset_control_assert -function reset_control_deassert -function reset_control_status -function reset_control_acquire -function reset_control_release -function reset_control_rearm -function reset_control_put -function of_reset_control_get_count -function of_reset_control_array_get -function devm_reset_control_array_get -function reset_control_get_count ./drivers/reset/core.c
+./diff-doc -rst -enable-lineno -function 'RFkill integration' ./include/net/cfg80211.h
+./diff-doc -rst -enable-lineno -function 'Ring Design' ./include/uapi/linux/target_core_user.h
+./diff-doc -rst -enable-lineno -function riscv_set_icache_flush_ctx ./arch/riscv/mm/cacheflush.c
+./diff-doc -rst -enable-lineno -function rng_alg ./include/crypto/rng.h
+./diff-doc -rst -enable-lineno -function rtnl_link_stats64 ./include/uapi/linux/if_link.h
+./diff-doc -rst -enable-lineno -function 'runtime pm' ./drivers/gpu/drm/i915/intel_runtime_pm.c
+./diff-doc -rst -enable-lineno -function 'RX A-MPDU aggregation' ./net/mac80211/agg-rx.c
+./diff-doc -rst -enable-lineno -function 'Scanning and BSS list handling' ./include/net/cfg80211.h
+./diff-doc -rst -enable-lineno -function 'scdc helpers' ./drivers/gpu/drm/display/drm_scdc_helper.c
+./diff-doc -rst -enable-lineno -function 'scope-based cleanup helpers' ./include/linux/cleanup.h
+./diff-doc -rst -enable-lineno -function serial_number ./drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+./diff-doc -rst -enable-lineno -function serial_rs485 -function uart_get_rs485_mode ./include/uapi/linux/serial.h
+./diff-doc -rst -enable-lineno -function set_key_cmd -function ieee80211_key_conf -function ieee80211_key_flags -function ieee80211_get_tkip_p1k -function ieee80211_get_tkip_p1k_iv -function ieee80211_get_tkip_p2k ./include/net/mac80211.h
+./diff-doc -rst -enable-lineno -function sgx_ioc_enclave_create -function sgx_ioc_enclave_add_pages -function sgx_ioc_enclave_init -function sgx_ioc_enclave_provision ./arch/x86/kernel/cpu/sgx/ioctl.c
+./diff-doc -rst -enable-lineno -function sgx_ioc_enclave_restrict_permissions -function sgx_ioc_enclave_modify_types -function sgx_ioc_enclave_remove_pages ./arch/x86/kernel/cpu/sgx/ioctl.c
+./diff-doc -rst -enable-lineno -function 'Shader validator for VC4.' ./drivers/gpu/drm/vc4/vc4_validate_shaders.c
+./diff-doc -rst -enable-lineno -function sig_alg ./include/crypto/sig.h
+./diff-doc -rst -enable-lineno -function 'Single Block Cipher API' ./include/crypto/internal/cipher.h
+./diff-doc -rst -enable-lineno -function 'skb checksums' ./include/linux/skbuff.h
+./diff-doc -rst -enable-lineno -function smartshift_apu_power ./drivers/gpu/drm/amd/pm/amdgpu_pm.c
+./diff-doc -rst -enable-lineno -function smartshift_bias ./drivers/gpu/drm/amd/pm/amdgpu_pm.c
+./diff-doc -rst -enable-lineno -function smartshift_dgpu_power ./drivers/gpu/drm/amd/pm/amdgpu_pm.c
+./diff-doc -rst -enable-lineno -function snd_soc_dai_set_bclk_ratio ./sound/soc/soc-dai.c
+./diff-doc -rst -enable-lineno -function snd_soc_dai_set_clkdiv ./sound/soc/soc-dai.c
+./diff-doc -rst -enable-lineno -function snd_soc_dai_set_pll ./sound/soc/soc-dai.c
+./diff-doc -rst -enable-lineno -function snd_soc_dai_set_sysclk ./sound/soc/soc-dai.c
+./diff-doc -rst -enable-lineno -function 'Spatial multiplexing power save' ./include/net/mac80211.h
+./diff-doc -rst -enable-lineno -function 'special care dsi' ./drivers/gpu/drm/drm_bridge.c
+./diff-doc -rst -enable-lineno -function spi_register_board_info ./drivers/spi/spi.c
+./diff-doc -rst -enable-lineno -function 'Split and Merge' ./drivers/gpu/drm/drm_gpuvm.c
+./diff-doc -rst -enable-lineno -function ssleep -function fsleep ./include/linux/delay.h
+./diff-doc -rst -enable-lineno -function sta_ampdu_mlme -function tid_ampdu_tx -function tid_ampdu_rx ./net/mac80211/sta_info.h
+./diff-doc -rst -enable-lineno -function sta_info -function ieee80211_sta_info_flags ./net/mac80211/sta_info.h
+./diff-doc -rst -enable-lineno -function 'STA information lifetime rules' ./net/mac80211/sta_info.c
+./diff-doc -rst -enable-lineno -function 'standard connector properties' ./drivers/gpu/drm/drm_connector.c
+./diff-doc -rst -enable-lineno -function 'standard CRTC properties' ./drivers/gpu/drm/drm_crtc.c
+./diff-doc -rst -enable-lineno -function 'standard plane properties' ./drivers/gpu/drm/drm_plane.c
+./diff-doc -rst -enable-lineno -function start_tty -function stop_tty ./drivers/tty/tty_io.c
+./diff-doc -rst -enable-lineno -function 'ST-Ericsson MCDE Driver' ./drivers/gpu/drm/mcde/mcde_drv.c
+./diff-doc -rst -enable-lineno -function stratix10_svc_cb_data ./include/linux/firmware/intel/stratix10-svc-client.h
+./diff-doc -rst -enable-lineno -function stratix10_svc_client ./include/linux/firmware/intel/stratix10-svc-client.h
+./diff-doc -rst -enable-lineno -function stratix10_svc_client_msg ./include/linux/firmware/intel/stratix10-svc-client.h
+./diff-doc -rst -enable-lineno -function stratix10_svc_command_code ./include/linux/firmware/intel/stratix10-svc-client.h
+./diff-doc -rst -enable-lineno -function stratix10_svc_command_config_type ./include/linux/firmware/intel/stratix10-svc-client.h
+./diff-doc -rst -enable-lineno -function struct -function dcp_blob_fmt ./security/keys/trusted-keys/trusted_dcp.c
+./diff-doc -rst -enable-lineno -function struct -function page_pool_params ./include/net/page_pool/types.h
+./diff-doc -rst -enable-lineno -function struct -function page_pool_recycle_stats -function struct -function page_pool_alloc_stats -function struct -function page_pool_stats ./include/net/page_pool/types.h
+./diff-doc -rst -enable-lineno -function struct -function virtqueue ./include/linux/virtio.h
+./diff-doc -rst -enable-lineno -function struct -function vring_desc ./include/uapi/linux/virtio_ring.h
+./diff-doc -rst -enable-lineno -function 'Supported input formats and encodings' ./include/drm/bridge/dw_hdmi.h
+./diff-doc -rst -enable-lineno -function 'Symmetric Key Cipher API' ./include/crypto/skcipher.h
+./diff-doc -rst -enable-lineno -function 'Symmetric Key Cipher Request Handle' ./include/crypto/skcipher.h
+./diff-doc -rst -enable-lineno -function 'Synchronous Message Digest API' ./include/crypto/hash.h
+./diff-doc -rst -enable-lineno -function sys_landlock_add_rule ./security/landlock/syscalls.c
+./diff-doc -rst -enable-lineno -function sys_landlock_create_ruleset ./security/landlock/syscalls.c
+./diff-doc -rst -enable-lineno -function sys_landlock_restrict_self ./security/landlock/syscalls.c
+./diff-doc -rst -enable-lineno -function sys_lsm_get_self_attr ./security/lsm_syscalls.c
+./diff-doc -rst -enable-lineno -function sys_lsm_list_modules ./security/lsm_syscalls.c
+./diff-doc -rst -enable-lineno -function sys_lsm_set_self_attr ./security/lsm_syscalls.c
+./diff-doc -rst -enable-lineno -function teo-description ./drivers/cpuidle/governors/teo.c
+./diff-doc -rst -enable-lineno -function 'Test mode' ./include/net/cfg80211.h
+./diff-doc -rst -enable-lineno -function textsearch_find -function textsearch_next -function \ -function textsearch_get_pattern -function textsearch_get_pattern_len ./include/linux/textsearch.h
+./diff-doc -rst -enable-lineno -function 'The i915 register macro definition style guide' ./drivers/gpu/drm/i915/i915_reg.h
+./diff-doc -rst -enable-lineno -function TH_LOG -function TEST -function TEST_SIGNAL -function FIXTURE -function FIXTURE_DATA -function FIXTURE_SETUP -function FIXTURE_TEARDOWN -function TEST_F -function TEST_HARNESS_MAIN -function FIXTURE_VARIANT -function FIXTURE_VARIANT_ADD ./tools/testing/selftests/kselftest_harness.h
+./diff-doc -rst -enable-lineno -function 'Tile group' ./drivers/gpu/drm/drm_connector.c
+./diff-doc -rst -enable-lineno -function 'tiling swizzling details' ./drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c
+./diff-doc -rst -enable-lineno -function ts_intro ./lib/textsearch.c
+./diff-doc -rst -enable-lineno -function TTM ./drivers/gpu/drm/ttm/ttm_module.c
+./diff-doc -rst -enable-lineno -function __tty_alloc_driver -function tty_driver_kref_put ./drivers/tty/tty_io.c
+./diff-doc -rst -enable-lineno -function tty_buffer_lock_exclusive -function tty_buffer_unlock_exclusive ./drivers/tty/tty_buffer.c
+./diff-doc -rst -enable-lineno -function tty_buffer_space_avail -function tty_buffer_set_limit ./drivers/tty/tty_buffer.c
+./diff-doc -rst -enable-lineno -function tty_do_resize ./drivers/tty/tty_io.c
+./diff-doc -rst -enable-lineno -function 'TTY Driver Flags' ./include/linux/tty_driver.h
+./diff-doc -rst -enable-lineno -function tty_driver ./include/linux/tty_driver.h
+./diff-doc -rst -enable-lineno -function tty_get_baud_rate ./include/linux/tty.h
+./diff-doc -rst -enable-lineno -function tty_hangup -function tty_vhangup -function tty_hung_up_p ./drivers/tty/tty_io.c
+./diff-doc -rst -enable-lineno -function tty_init_termios ./drivers/tty/tty_io.c
+./diff-doc -rst -enable-lineno -function tty_insert_flip_string_fixed_flag -function tty_insert_flip_string_flags -function tty_insert_flip_char ./include/linux/tty_flip.h
+./diff-doc -rst -enable-lineno -function tty_kopen_exclusive -function tty_kopen_shared -function tty_kclose ./drivers/tty/tty_io.c
+./diff-doc -rst -enable-lineno -function tty_kref_get ./include/linux/tty.h
+./diff-doc -rst -enable-lineno -function tty_kref_put ./drivers/tty/tty_io.c
+./diff-doc -rst -enable-lineno -function tty_ldisc_ops ./include/linux/tty_ldisc.h
+./diff-doc -rst -enable-lineno -function tty_ldisc_ref_wait -function tty_ldisc_ref -function tty_ldisc_deref ./drivers/tty/tty_ldisc.c
+./diff-doc -rst -enable-lineno -function tty_name ./drivers/tty/tty_io.c
+./diff-doc -rst -enable-lineno -function tty_operations ./include/linux/tty_driver.h
+./diff-doc -rst -enable-lineno -function tty_port_carrier_raised -function tty_port_raise_dtr_rts -function tty_port_lower_dtr_rts ./drivers/tty/tty_port.c
+./diff-doc -rst -enable-lineno -function tty_port ./include/linux/tty_port.h
+./diff-doc -rst -enable-lineno -function tty_port_init -function tty_port_destroy -function tty_port_get -function tty_port_put ./drivers/tty/tty_port.c
+./diff-doc -rst -enable-lineno -function tty_port_install -function tty_port_open -function tty_port_block_til_ready -function tty_port_close -function tty_port_close_start -function tty_port_close_end -function tty_port_hangup -function tty_port_shutdown ./drivers/tty/tty_port.c
+./diff-doc -rst -enable-lineno -function tty_port_link_device -function tty_port_register_device -function tty_port_register_device_attr ./drivers/tty/tty_port.c
+./diff-doc -rst -enable-lineno -function tty_port_operations ./include/linux/tty_port.h
+./diff-doc -rst -enable-lineno -function tty_port_tty_get -function tty_port_tty_set ./drivers/tty/tty_port.c
+./diff-doc -rst -enable-lineno -function tty_port_tty_hangup -function tty_port_tty_wakeup ./drivers/tty/tty_port.c
+./diff-doc -rst -enable-lineno -function tty_prepare_flip_string -function tty_flip_buffer_push -function tty_ldisc_receive_buf ./drivers/tty/tty_buffer.c
+./diff-doc -rst -enable-lineno -function tty_put_char ./drivers/tty/tty_io.c
+./diff-doc -rst -enable-lineno -function tty_register_device -function tty_register_device_attr -function tty_unregister_device ./drivers/tty/tty_io.c
+./diff-doc -rst -enable-lineno -function tty_register_driver -function tty_unregister_driver ./drivers/tty/tty_io.c
+./diff-doc -rst -enable-lineno -function tty_register_ldisc -function tty_unregister_ldisc ./drivers/tty/tty_ldisc.c
+./diff-doc -rst -enable-lineno -function tty_release_struct -function tty_dev_name_to_number -function tty_get_icount ./drivers/tty/tty_io.c
+./diff-doc -rst -enable-lineno -function tty_set_ldisc -function tty_ldisc_flush ./drivers/tty/tty_ldisc.c
+./diff-doc -rst -enable-lineno -function tty_standard_install ./drivers/tty/tty_io.c
+./diff-doc -rst -enable-lineno -function 'TTY Struct Flags' ./include/linux/tty.h
+./diff-doc -rst -enable-lineno -function tty_struct ./include/linux/tty.h
+./diff-doc -rst -enable-lineno -function tty_wakeup ./drivers/tty/tty_io.c
+./diff-doc -rst -enable-lineno -function 'TX A-MPDU aggregation' ./net/mac80211/agg-tx.c
+./diff-doc -rst -enable-lineno -function typec_altmode_driver -function typec_altmode_ops ./include/linux/usb/typec_altmode.h
+./diff-doc -rst -enable-lineno -function typec_altmode_enter -function typec_altmode_exit -function typec_altmode_attention -function typec_altmode_vdm -function typec_altmode_notify ./drivers/usb/typec/bus.c
+./diff-doc -rst -enable-lineno -function typec_altmode_get_plug -function typec_altmode_put_plug ./drivers/usb/typec/bus.c
+./diff-doc -rst -enable-lineno -function typec_altmode_register_driver -function typec_altmode_unregister_driver ./include/linux/usb/typec_altmode.h
+./diff-doc -rst -enable-lineno -function typec_altmode_update_active ./drivers/usb/typec/class.c
+./diff-doc -rst -enable-lineno -function typec_cable_set_identity ./drivers/usb/typec/class.c
+./diff-doc -rst -enable-lineno -function typec_match_altmode ./drivers/usb/typec/bus.c
+./diff-doc -rst -enable-lineno -function typec_partner_register_altmode ./drivers/usb/typec/class.c
+./diff-doc -rst -enable-lineno -function typec_partner_set_identity ./drivers/usb/typec/class.c
+./diff-doc -rst -enable-lineno -function typec_plug_register_altmode ./drivers/usb/typec/class.c
+./diff-doc -rst -enable-lineno -function typec_port_register_altmode ./drivers/usb/typec/class.c
+./diff-doc -rst -enable-lineno -function typec_register_cable -function typec_unregister_cable -function typec_register_plug -function typec_unregister_plug ./drivers/usb/typec/class.c
+./diff-doc -rst -enable-lineno -function typec_register_partner -function typec_unregister_partner ./drivers/usb/typec/class.c
+./diff-doc -rst -enable-lineno -function typec_register_port -function typec_unregister_port ./drivers/usb/typec/class.c
+./diff-doc -rst -enable-lineno -function typec_set_data_role -function typec_set_pwr_role -function typec_set_vconn_role -function typec_set_pwr_opmode ./drivers/usb/typec/class.c
+./diff-doc -rst -enable-lineno -function typec_set_orientation -function typec_set_mode ./drivers/usb/typec/class.c
+./diff-doc -rst -enable-lineno -function typec_switch_register -function typec_switch_unregister -function typec_mux_register -function typec_mux_unregister ./drivers/usb/typec/mux.c
+./diff-doc -rst -enable-lineno -function typec_unregister_altmode ./drivers/usb/typec/class.c
+./diff-doc -rst -enable-lineno -function UAPI ./include/uapi/linux/cxl_mem.h
+./diff-doc -rst -enable-lineno -function uart_ops ./include/linux/serial_core.h
+./diff-doc -rst -enable-lineno -function uart_port_tx_limited -function uart_port_tx ./include/linux/serial_core.h
+./diff-doc -rst -enable-lineno -function uart_update_timeout -function uart_get_baud_rate -function uart_get_divisor -function uart_match_port -function uart_write_wakeup -function uart_register_driver -function uart_unregister_driver -function uart_suspend_port -function uart_resume_port -function uart_add_one_port -function uart_remove_one_port -function uart_console_write -function uart_parse_earlycon -function uart_parse_options -function uart_set_options -function uart_get_lsr_info -function uart_handle_dcd_change -function uart_handle_cts_change -function uart_try_toggle_sysrq -function uart_get_console ./drivers/tty/serial/serial_core.c
+./diff-doc -rst -enable-lineno -function udelay -function ndelay ./include/asm-generic/delay.h
+./diff-doc -rst -enable-lineno -function unique_id ./drivers/gpu/drm/amd/pm/amdgpu_pm.c
+./diff-doc -rst -enable-lineno -function USAGE ./drivers/base/auxiliary.c
+./diff-doc -rst -enable-lineno -function usb_dfu_functional_descriptor ./include/uapi/linux/usb/functionfs.h
+./diff-doc -rst -enable-lineno -function 'Useful GFP flag combinations' ./include/linux/gfp_types.h
+./diff-doc -rst -enable-lineno -function 'User command execution' ./drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+./diff-doc -rst -enable-lineno -function 'Userspace I/O' ./drivers/target/target_core_user.c
+./diff-doc -rst -enable-lineno -function usleep_range -function usleep_range_idle ./include/linux/delay.h
+./diff-doc -rst -enable-lineno -function usleep_range_state ./kernel/time/sleep_timeout.c
+./diff-doc -rst -enable-lineno -function 'Utility functions' ./include/net/cfg80211.h
+./diff-doc -rst -enable-lineno -function 'V3D GEM BO management support' ./drivers/gpu/drm/v3d/v3d_bo.c
+./diff-doc -rst -enable-lineno -function 'Variable refresh properties' ./drivers/gpu/drm/drm_connector.c
+./diff-doc -rst -enable-lineno -function 'vblank handling' ./drivers/gpu/drm/drm_vblank.c
+./diff-doc -rst -enable-lineno -function 'vblank works' ./drivers/gpu/drm/drm_vblank_work.c
+./diff-doc -rst -enable-lineno -function 'VC4 CRTC module' ./drivers/gpu/drm/vc4/vc4_crtc.c
+./diff-doc -rst -enable-lineno -function 'VC4 DPI module' ./drivers/gpu/drm/vc4/vc4_dpi.c
+./diff-doc -rst -enable-lineno -function 'VC4 DSI0/DSI1 module' ./drivers/gpu/drm/vc4/vc4_dsi.c
+./diff-doc -rst -enable-lineno -function 'VC4 Falcon HDMI module' ./drivers/gpu/drm/vc4/vc4_hdmi.c
+./diff-doc -rst -enable-lineno -function 'VC4 GEM BO management support' ./drivers/gpu/drm/vc4/vc4_bo.c
+./diff-doc -rst -enable-lineno -function 'VC4 HVS module.' ./drivers/gpu/drm/vc4/vc4_hvs.c
+./diff-doc -rst -enable-lineno -function 'VC4 plane module' ./drivers/gpu/drm/vc4/vc4_plane.c
+./diff-doc -rst -enable-lineno -function 'VC4 SDTV module' ./drivers/gpu/drm/vc4/vc4_vec.c
+./diff-doc -rst -enable-lineno -function vdso_sgx_enter_enclave_t ./arch/x86/include/uapi/asm/sgx.h
+./diff-doc -rst -enable-lineno -function vgasr_priv ./drivers/gpu/vga/vga_switcheroo.c
+./diff-doc -rst -enable-lineno -function vga_switcheroo_client ./drivers/gpu/vga/vga_switcheroo.c
+./diff-doc -rst -enable-lineno -function vga_switcheroo_client_id ./include/linux/vga_switcheroo.h
+./diff-doc -rst -enable-lineno -function vga_switcheroo_client_ops ./include/linux/vga_switcheroo.h
+./diff-doc -rst -enable-lineno -function vga_switcheroo_handler_flags_t ./include/linux/vga_switcheroo.h
+./diff-doc -rst -enable-lineno -function vga_switcheroo_handler ./include/linux/vga_switcheroo.h
+./diff-doc -rst -enable-lineno -function vga_switcheroo_state ./include/linux/vga_switcheroo.h
+./diff-doc -rst -enable-lineno -function 'Video BIOS Table (VBT)' ./drivers/gpu/drm/i915/display/intel_bios.c
+./diff-doc -rst -enable-lineno -function 'Video Clocks' ./drivers/gpu/drm/meson/meson_vclk.c
+./diff-doc -rst -enable-lineno -function 'Video Encoder' ./drivers/gpu/drm/meson/meson_venc.c
+./diff-doc -rst -enable-lineno -function 'Video Input Unit' ./drivers/gpu/drm/meson/meson_viu.c
+./diff-doc -rst -enable-lineno -function 'Video Post Processing' ./drivers/gpu/drm/meson/meson_vpp.c
+./diff-doc -rst -enable-lineno -function 'Video Processing Unit' ./drivers/gpu/drm/meson/meson_drv.c
+./diff-doc -rst -enable-lineno -function virtio_device_ready ./include/linux/virtio_config.h
+./diff-doc -rst -enable-lineno -function virtqueue_add_inbuf ./drivers/virtio/virtio_ring.c
+./diff-doc -rst -enable-lineno -function virtqueue_add_outbuf ./drivers/virtio/virtio_ring.c
+./diff-doc -rst -enable-lineno -function virtqueue_add_sgs ./drivers/virtio/virtio_ring.c
+./diff-doc -rst -enable-lineno -function virtqueue_disable_cb ./drivers/virtio/virtio_ring.c
+./diff-doc -rst -enable-lineno -function virtqueue_enable_cb ./drivers/virtio/virtio_ring.c
+./diff-doc -rst -enable-lineno -function virtqueue_get_buf_ctx ./drivers/virtio/virtio_ring.c
+./diff-doc -rst -enable-lineno -function 'Virtual Memory Address' ./drivers/gpu/drm/i915/i915_vma_types.h
+./diff-doc -rst -enable-lineno -function 'vkms (Virtual Kernel Modesetting)' ./drivers/gpu/drm/vkms/vkms_drv.c
+./diff-doc -rst -enable-lineno -function 'vma offset manager' ./drivers/gpu/drm/drm_vma_manager.c
+./diff-doc -rst -enable-lineno -function vring_interrupt ./drivers/virtio/virtio_ring.c
+./diff-doc -rst -enable-lineno -function vtpmx_ioc_new_dev ./drivers/char/tpm/tpm_vtpm_proxy.c
+./diff-doc -rst -enable-lineno -function 'Watermark modifiers' ./include/linux/gfp_types.h
+./diff-doc -rst -enable-lineno -function wiphy_rfkill_set_hw_state -function wiphy_rfkill_start_polling -function wiphy_rfkill_stop_polling ./include/net/cfg80211.h
+./diff-doc -rst -enable-lineno -function 'WOPCM Layout' ./drivers/gpu/drm/i915/gt/intel_wopcm.c
+./diff-doc -rst -enable-lineno -function 'Write Once Protected Content Memory (WOPCM) Layout' ./drivers/gpu/drm/xe/xe_wopcm.c
+./diff-doc -rst -enable-lineno -function 'xdp redirect' ./net/core/filter.c
+./diff-doc -rst -enable-lineno -function 'Xe device coredump' ./drivers/gpu/drm/xe/xe_devcoredump.c
+./diff-doc -rst -enable-lineno -function 'Xe Power Management' ./drivers/gpu/drm/xe/xe_pm.c
+./diff-doc -rst -enable-lineno -function XSDFEC_ADD_LDPC_CODE_PARAMS ./include/uapi/misc/xilinx_sdfec.h
+./diff-doc -rst -enable-lineno -function XSDFEC_CLEAR_STATS ./include/uapi/misc/xilinx_sdfec.h
+./diff-doc -rst -enable-lineno -function XSDFEC_GET_CONFIG ./include/uapi/misc/xilinx_sdfec.h
+./diff-doc -rst -enable-lineno -function XSDFEC_GET_STATS ./include/uapi/misc/xilinx_sdfec.h
+./diff-doc -rst -enable-lineno -function XSDFEC_GET_STATUS ./include/uapi/misc/xilinx_sdfec.h
+./diff-doc -rst -enable-lineno -function XSDFEC_IS_ACTIVE ./include/uapi/misc/xilinx_sdfec.h
+./diff-doc -rst -enable-lineno -function XSDFEC_SET_BYPASS ./include/uapi/misc/xilinx_sdfec.h
+./diff-doc -rst -enable-lineno -function XSDFEC_SET_DEFAULT_CONFIG ./include/uapi/misc/xilinx_sdfec.h
+./diff-doc -rst -enable-lineno -function XSDFEC_SET_IRQ ./include/uapi/misc/xilinx_sdfec.h
+./diff-doc -rst -enable-lineno -function XSDFEC_SET_ORDER ./include/uapi/misc/xilinx_sdfec.h
+./diff-doc -rst -enable-lineno -function XSDFEC_SET_TURBO ./include/uapi/misc/xilinx_sdfec.h
+./diff-doc -rst -enable-lineno -function XSDFEC_START_DEV ./include/uapi/misc/xilinx_sdfec.h
+./diff-doc -rst -enable-lineno -function XSDFEC_STOP_DEV ./include/uapi/misc/xilinx_sdfec.h
+./diff-doc -rst -enable-lineno ./include/linux/bio.h
+./diff-doc -rst -enable-lineno ./include/linux/blk-mq.h
+./diff-doc -rst -enable-lineno ./include/linux/bootconfig.h
+./diff-doc -rst -enable-lineno ./include/linux/buffer_head.h
+./diff-doc -rst -enable-lineno ./include/linux/connector.h
+./diff-doc -rst -enable-lineno ./include/linux/cpuhotplug.h
+./diff-doc -rst -enable-lineno ./include/linux/damon.h
+./diff-doc -rst -enable-lineno ./include/linux/devcoredump.h
+./diff-doc -rst -enable-lineno ./include/linux/devfreq-event.h
+./diff-doc -rst -enable-lineno ./include/linux/devfreq.h
+./diff-doc -rst -enable-lineno ./include/linux/edac.h
+./diff-doc -rst -enable-lineno ./include/linux/folio_queue.h
+./diff-doc -rst -enable-lineno ./include/linux/fprobe.h
+./diff-doc -rst -enable-lineno ./include/linux/fscache-cache.h
+./diff-doc -rst -enable-lineno ./include/linux/fscache.h
+./diff-doc -rst -enable-lineno ./include/linux/highmem.h
+./diff-doc -rst -enable-lineno ./include/linux/highmem-internal.h
+./diff-doc -rst -enable-lineno ./include/linux/host1x.h
+./diff-doc -rst -enable-lineno ./include/linux/hte.h
+./diff-doc -rst -enable-lineno ./include/linux/i2c-atr.h
+./diff-doc -rst -enable-lineno ./include/linux/i3c/device.h
+./diff-doc -rst -enable-lineno ./include/linux/i3c/master.h
+./diff-doc -rst -enable-lineno ./include/linux/iio/buffer.h
+./diff-doc -rst -enable-lineno ./include/linux/iio/iio.h
+./diff-doc -rst -enable-lineno ./include/linux/iio/trigger.h
+./diff-doc -rst -enable-lineno ./include/linux/interconnect-provider.h
+./diff-doc -rst -enable-lineno ./include/linux/int_log.h
+./diff-doc -rst -enable-lineno ./include/linux/irqdomain.h
+./diff-doc -rst -enable-lineno ./include/linux/kref.h
+./diff-doc -rst -enable-lineno ./include/linux/maple_tree.h
+./diff-doc -rst -enable-lineno ./include/linux/memblock.h
+./diff-doc -rst -enable-lineno ./include/linux/migrate.h
+./diff-doc -rst -enable-lineno ./include/linux/mm_inline.h
+./diff-doc -rst -enable-lineno ./include/linux/mmzone.h
+./diff-doc -rst -enable-lineno ./include/linux/netfs.h
+./diff-doc -rst -enable-lineno ./include/linux/padata.h
+./diff-doc -rst -enable-lineno ./include/linux/page-flags.h
+./diff-doc -rst -enable-lineno ./include/linux/page_ref.h
+./diff-doc -rst -enable-lineno ./include/linux/peci.h
+./diff-doc -rst -enable-lineno ./include/linux/pm.h
+./diff-doc -rst -enable-lineno ./include/linux/rculist_bl.h
+./diff-doc -rst -enable-lineno ./include/linux/rculist.h
+./diff-doc -rst -enable-lineno ./include/linux/rculist_nulls.h
+./diff-doc -rst -enable-lineno ./include/linux/rcupdate.h
+./diff-doc -rst -enable-lineno ./include/linux/rcupdate_trace.h
+./diff-doc -rst -enable-lineno ./include/linux/rcupdate_wait.h
+./diff-doc -rst -enable-lineno ./include/linux/rcuref.h
+./diff-doc -rst -enable-lineno ./include/linux/rcu_sync.h
+./diff-doc -rst -enable-lineno ./include/linux/rcutree.h
+./diff-doc -rst -enable-lineno ./include/linux/seqlock.h
+./diff-doc -rst -enable-lineno ./include/linux/srcu.h
+./diff-doc -rst -enable-lineno ./include/linux/surface_acpi_notify.h
+./diff-doc -rst -enable-lineno ./include/linux/surface_aggregator/controller.h
+./diff-doc -rst -enable-lineno ./include/linux/surface_aggregator/device.h
+./diff-doc -rst -enable-lineno ./include/linux/surface_aggregator/serial_hub.h
+./diff-doc -rst -enable-lineno ./include/linux/workqueue.h
+./diff-doc -rst -enable-lineno ./include/linux/xarray.h
+./diff-doc -rst -enable-lineno ./include/linux/xz.h
+./diff-doc -rst -enable-lineno ./include/media/cec-notifier.h
+./diff-doc -rst -enable-lineno ./include/media/cec-pin.h
+./diff-doc -rst -enable-lineno ./include/media/demux.h
+./diff-doc -rst -enable-lineno ./include/media/dmxdev.h
+./diff-doc -rst -enable-lineno ./include/media/dvb_ca_en50221.h
+./diff-doc -rst -enable-lineno ./include/media/dvb_demux.h
+./diff-doc -rst -enable-lineno ./include/media/dvbdev.h
+./diff-doc -rst -enable-lineno ./include/media/dvb_frontend.h
+./diff-doc -rst -enable-lineno ./include/media/dvb_net.h
+./diff-doc -rst -enable-lineno ./include/media/dvb_ringbuffer.h
+./diff-doc -rst -enable-lineno ./include/media/dvb_vb2.h
+./diff-doc -rst -enable-lineno ./include/media/media-dev-allocator.h
+./diff-doc -rst -enable-lineno ./include/media/media-device.h
+./diff-doc -rst -enable-lineno ./include/media/media-devnode.h
+./diff-doc -rst -enable-lineno ./include/media/media-entity.h
+./diff-doc -rst -enable-lineno ./include/media/media-request.h
+./diff-doc -rst -enable-lineno ./include/media/rc-core.h
+./diff-doc -rst -enable-lineno ./include/media/rc-map.h
+./diff-doc -rst -enable-lineno ./include/media/tuner.h
+./diff-doc -rst -enable-lineno ./include/media/tuner-types.h
+./diff-doc -rst -enable-lineno ./include/media/tveeprom.h
+./diff-doc -rst -enable-lineno ./include/media/v4l2-async.h
+./diff-doc -rst -enable-lineno ./include/media/v4l2-cci.h
+./diff-doc -rst -enable-lineno ./include/media/v4l2-common.h
+./diff-doc -rst -enable-lineno ./include/media/v4l2-ctrls.h
+./diff-doc -rst -enable-lineno ./include/media/v4l2-dev.h
+./diff-doc -rst -enable-lineno ./include/media/v4l2-device.h
+./diff-doc -rst -enable-lineno ./include/media/v4l2-dv-timings.h
+./diff-doc -rst -enable-lineno ./include/media/v4l2-event.h
+./diff-doc -rst -enable-lineno ./include/media/v4l2-fh.h
+./diff-doc -rst -enable-lineno ./include/media/v4l2-flash-led-class.h
+./diff-doc -rst -enable-lineno ./include/media/v4l2-fwnode.h
+./diff-doc -rst -enable-lineno ./include/media/v4l2-ioctl.h
+./diff-doc -rst -enable-lineno ./include/media/v4l2-mc.h
+./diff-doc -rst -enable-lineno ./include/media/v4l2-mediabus.h
+./diff-doc -rst -enable-lineno ./include/media/v4l2-mem2mem.h
+./diff-doc -rst -enable-lineno ./include/media/v4l2-rect.h
+./diff-doc -rst -enable-lineno ./include/media/v4l2-subdev.h
+./diff-doc -rst -enable-lineno ./include/media/videobuf2-core.h
+./diff-doc -rst -enable-lineno ./include/media/videobuf2-memops.h
+./diff-doc -rst -enable-lineno ./include/media/videobuf2-v4l2.h
+./diff-doc -rst -enable-lineno ./include/sound/compress_driver.h
+./diff-doc -rst -enable-lineno ./include/sound/control.h
+./diff-doc -rst -enable-lineno ./include/sound/core.h
+./diff-doc -rst -enable-lineno ./include/sound/dmaengine_pcm.h
+./diff-doc -rst -enable-lineno ./include/sound/jack.h
+./diff-doc -rst -enable-lineno ./include/sound/pcm.h
+./diff-doc -rst -enable-lineno ./include/sound/soc.h
+./diff-doc -rst -enable-lineno ./include/uapi/drm/i915_drm.h
+./diff-doc -rst -enable-lineno ./include/uapi/drm/nouveau_drm.h
+./diff-doc -rst -enable-lineno ./include/uapi/drm/panthor_drm.h
+./diff-doc -rst -enable-lineno ./include/uapi/drm/xe_drm.h
+./diff-doc -rst -enable-lineno ./include/uapi/linux/dma-buf.h
+./diff-doc -rst -enable-lineno ./include/uapi/linux/dpll.h
+./diff-doc -rst -enable-lineno ./include/uapi/linux/dvb/ca.h
+./diff-doc -rst -enable-lineno ./include/uapi/linux/dvb/dmx.h
+./diff-doc -rst -enable-lineno ./include/uapi/linux/dvb/frontend.h
+./diff-doc -rst -enable-lineno ./include/uapi/linux/dvb/net.h
+./diff-doc -rst -enable-lineno ./include/uapi/linux/iommufd.h
+./diff-doc -rst -enable-lineno ./include/uapi/linux/media/raspberrypi/pisp_be_config.h
+./diff-doc -rst -enable-lineno ./include/uapi/linux/netlink.h
+./diff-doc -rst -enable-lineno ./include/uapi/linux/rkisp1-config.h
+./diff-doc -rst -enable-lineno ./include/uapi/linux/surface_aggregator/cdev.h
+./diff-doc -rst -enable-lineno ./include/uapi/linux/surface_aggregator/dtx.h
+./diff-doc -rst -enable-lineno ./include/uapi/linux/vtpm_proxy.h
+./diff-doc -rst -enable-lineno ./include/uapi/sound/compress_offload.h
+./diff-doc -rst -enable-lineno ./include/uapi/sound/compress_params.h
+./diff-doc -rst -enable-lineno -internal ./arch/powerpc/sysdev/fsl_rio.c
+./diff-doc -rst -enable-lineno -internal ./arch/s390/include/asm/ccwdev.h
+./diff-doc -rst -enable-lineno -internal ./arch/s390/include/asm/ccwgroup.h
+./diff-doc -rst -enable-lineno -internal ./arch/s390/include/asm/cio.h
+./diff-doc -rst -enable-lineno -internal ./arch/s390/include/uapi/asm/cmb.h
+./diff-doc -rst -enable-lineno -internal ./arch/sh/boards/mach-dreamcast/rtc.c
+./diff-doc -rst -enable-lineno -internal ./arch/x86/include/asm/io.h
+./diff-doc -rst -enable-lineno -internal ./arch/x86/include/asm/uaccess.h
+./diff-doc -rst -enable-lineno -internal ./block/blk-core.c
+./diff-doc -rst -enable-lineno -internal ./block/blk-sysfs.c
+./diff-doc -rst -enable-lineno -internal ./block/genhd.c
+./diff-doc -rst -enable-lineno -internal ./drivers/ata/ata_piix.c
+./diff-doc -rst -enable-lineno -internal ./drivers/ata/libata-core.c
+./diff-doc -rst -enable-lineno -internal ./drivers/ata/libata-scsi.c
+./diff-doc -rst -enable-lineno -internal ./drivers/ata/sata_sil.c
+./diff-doc -rst -enable-lineno -internal ./drivers/base/init.c
+./diff-doc -rst -enable-lineno -internal ./drivers/base/node.c
+./diff-doc -rst -enable-lineno -internal ./drivers/cxl/cxl.h
+./diff-doc -rst -enable-lineno -internal ./drivers/cxl/cxlmem.h
+./diff-doc -rst -enable-lineno -internal ./drivers/cxl/pci.c
+./diff-doc -rst -enable-lineno -internal ./drivers/firmware/edd.c
+./diff-doc -rst -enable-lineno -internal ./drivers/firmware/efi/libstub/mem.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/amd/display/dc/dc.h
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/arm/display/komeda/komeda_kms.h
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/arm/display/komeda/komeda_plane.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/i915/display/intel_atomic_plane.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/i915/display/intel_audio.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/i915/display/intel_bios.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/i915/display/intel_cdclk.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/i915/display/intel_dmc.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/i915/display/intel_dpll_mgr.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/i915/display/intel_dpll_mgr.h
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/i915/display/intel_drrs.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/i915/display/intel_dsb.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/i915/display/intel_fbc.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/i915/display/intel_fifo_underrun.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/i915/display/intel_frontbuffer.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/i915/display/intel_frontbuffer.h
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/i915/display/intel_hotplug.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/i915/display/intel_lpe_audio.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/i915/display/intel_psr.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/i915/display/intel_vbt_defs.h
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/i915/gem/i915_gem_shrinker.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/i915/gem/i915_gem_tiling.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/i915/gt/intel_gt_mcr.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/i915/gt/uc/intel_guc_fw.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/i915/i915_cmd_parser.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/i915/i915_gem_evict.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/i915/i915_gem_gtt.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/i915/i915_vgpu.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/i915/intel_gvt.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/i915/intel_runtime_pm.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/i915/intel_uncore.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/xe/xe_devcoredump.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/xe/xe_ggtt.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/xe/xe_ggtt_types.h
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/xe/xe_pcode.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/xe/xe_pm.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/xe/xe_rtp.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/xe/xe_rtp.h
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/xe/xe_rtp_types.h
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/xe/xe_tile.c
+./diff-doc -rst -enable-lineno -internal ./drivers/gpu/drm/xe/xe_wa.c
+./diff-doc -rst -enable-lineno -internal ./drivers/infiniband/core/iwpm_util.h
+./diff-doc -rst -enable-lineno -internal ./drivers/infiniband/ulp/iser/iscsi_iser.h
+./diff-doc -rst -enable-lineno -internal ./drivers/infiniband/ulp/iser/iser_initiator.c
+./diff-doc -rst -enable-lineno -internal ./drivers/infiniband/ulp/iser/iser_verbs.c
+./diff-doc -rst -enable-lineno -internal ./drivers/infiniband/ulp/isert/ib_isert.c
+./diff-doc -rst -enable-lineno -internal ./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h
+./diff-doc -rst -enable-lineno -internal ./drivers/infiniband/ulp/opa_vnic/opa_vnic_internal.h
+./diff-doc -rst -enable-lineno -internal ./drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
+./diff-doc -rst -enable-lineno -internal ./drivers/infiniband/ulp/opa_vnic/opa_vnic_vema_iface.c
+./diff-doc -rst -enable-lineno -internal ./drivers/infiniband/ulp/srpt/ib_srpt.c
+./diff-doc -rst -enable-lineno -internal ./drivers/infiniband/ulp/srpt/ib_srpt.h
+./diff-doc -rst -enable-lineno -internal ./drivers/media/test-drivers/vimc/vimc-streamer.h
+./diff-doc -rst -enable-lineno -internal ./drivers/mtd/nand/raw/nand_base.c
+./diff-doc -rst -enable-lineno -internal ./drivers/mtd/nand/raw/nand_bbt.c
+./diff-doc -rst -enable-lineno -internal ./drivers/net/can/ctucanfd/ctucanfd_base.c
+./diff-doc -rst -enable-lineno -internal ./drivers/net/can/ctucanfd/ctucanfd.h
+./diff-doc -rst -enable-lineno -internal ./drivers/net/can/ctucanfd/ctucanfd_pci.c
+./diff-doc -rst -enable-lineno -internal ./drivers/net/can/ctucanfd/ctucanfd_platform.c
+./diff-doc -rst -enable-lineno -internal ./drivers/net/phy/mdio_bus.c
+./diff-doc -rst -enable-lineno -internal ./drivers/net/phy/phy.c
+./diff-doc -rst -enable-lineno -internal ./drivers/net/phy/phy_device.c
+./diff-doc -rst -enable-lineno -internal ./drivers/net/phy/sfp-bus.c
+./diff-doc -rst -enable-lineno -internal ./drivers/parport/daisy.c
+./diff-doc -rst -enable-lineno -internal ./drivers/pci/pci-sysfs.c
+./diff-doc -rst -enable-lineno -internal ./drivers/platform/surface/aggregator/bus.c
+./diff-doc -rst -enable-lineno -internal ./drivers/platform/surface/aggregator/controller.c
+./diff-doc -rst -enable-lineno -internal ./drivers/platform/surface/aggregator/controller.h
+./diff-doc -rst -enable-lineno -internal ./drivers/platform/surface/aggregator/core.c
+./diff-doc -rst -enable-lineno -internal ./drivers/platform/surface/aggregator/ssh_msgb.h
+./diff-doc -rst -enable-lineno -internal ./drivers/platform/surface/aggregator/ssh_packet_layer.c
+./diff-doc -rst -enable-lineno -internal ./drivers/platform/surface/aggregator/ssh_packet_layer.h
+./diff-doc -rst -enable-lineno -internal ./drivers/platform/surface/aggregator/ssh_parser.c
+./diff-doc -rst -enable-lineno -internal ./drivers/platform/surface/aggregator/ssh_parser.h
+./diff-doc -rst -enable-lineno -internal ./drivers/platform/surface/aggregator/ssh_request_layer.c
+./diff-doc -rst -enable-lineno -internal ./drivers/platform/surface/aggregator/ssh_request_layer.h
+./diff-doc -rst -enable-lineno -internal ./drivers/pnp/core.c
+./diff-doc -rst -enable-lineno -internal ./drivers/pnp/driver.c
+./diff-doc -rst -enable-lineno -internal ./drivers/rapidio/rio-access.c
+./diff-doc -rst -enable-lineno -internal ./drivers/rapidio/rio.c
+./diff-doc -rst -enable-lineno -internal ./drivers/rapidio/rio-driver.c
+./diff-doc -rst -enable-lineno -internal ./drivers/rapidio/rio-scan.c
+./diff-doc -rst -enable-lineno -internal ./drivers/scsi/iscsi_tcp.c
+./diff-doc -rst -enable-lineno -internal ./drivers/scsi/scsi_netlink.c
+./diff-doc -rst -enable-lineno -internal ./drivers/slimbus/slimbus.h
+./diff-doc -rst -enable-lineno -internal ./drivers/staging/vme_user/vme.h
+./diff-doc -rst -enable-lineno -internal ./drivers/tty/n_tty.c
+./diff-doc -rst -enable-lineno -internal ./drivers/tty/tty_buffer.c
+./diff-doc -rst -enable-lineno -internal ./drivers/tty/tty_io.c
+./diff-doc -rst -enable-lineno -internal ./drivers/tty/tty_ldisc.c
+./diff-doc -rst -enable-lineno -internal ./drivers/tty/vt/selection.c
+./diff-doc -rst -enable-lineno -internal ./drivers/tty/vt/vt.c
+./diff-doc -rst -enable-lineno -internal ./drivers/usb/core/buffer.c
+./diff-doc -rst -enable-lineno -internal ./drivers/usb/dwc3/core.c
+./diff-doc -rst -enable-lineno -internal ./drivers/usb/dwc3/core.h
+./diff-doc -rst -enable-lineno -internal ./drivers/usb/dwc3/gadget.c
+./diff-doc -rst -enable-lineno -internal ./drivers/usb/dwc3/gadget.h
+./diff-doc -rst -enable-lineno -internal ./drivers/video/fbdev/core/modedb.c
+./diff-doc -rst -enable-lineno -internal ./drivers/w1/w1.c
+./diff-doc -rst -enable-lineno -internal ./drivers/w1/w1_internal.h
+./diff-doc -rst -enable-lineno -internal ./drivers/w1/w1_io.c
+./diff-doc -rst -enable-lineno -internal ./drivers/w1/w1_netlink.h
+./diff-doc -rst -enable-lineno -internal ./fs/eventpoll.c
+./diff-doc -rst -enable-lineno -internal ./fs/jbd2/recovery.c
+./diff-doc -rst -enable-lineno -internal ./fs/locks.c
+./diff-doc -rst -enable-lineno -internal ./fs/proc/base.c
+./diff-doc -rst -enable-lineno -internal ./fs/pstore/zone.c
+./diff-doc -rst -enable-lineno -internal ./include/asm-generic/bitops/instrumented-atomic.h
+./diff-doc -rst -enable-lineno -internal ./include/asm-generic/bitops/instrumented-lock.h
+./diff-doc -rst -enable-lineno -internal ./include/asm-generic/bitops/instrumented-non-atomic.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/display/drm_dp_dual_mode_helper.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/display/drm_dp.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/display/drm_dp_helper.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/display/drm_dp_mst_helper.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/display/drm_dsc.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/display/drm_scdc_helper.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_atomic.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_atomic_helper.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_auth.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_bridge.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_client.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_color_mgmt.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_connector.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_crtc.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_damage_helper.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_debugfs.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_device.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_drv.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_edid.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_eld.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_encoder.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_exec.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_fb_helper.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_file.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_flip_work.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_fourcc.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_framebuffer.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_gem_atomic_helper.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_gem_dma_helper.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_gem.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_gem_shmem_helper.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_gem_vram_helper.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_gpuvm.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_ioctl.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_managed.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_mipi_dbi.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_mipi_dsi.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_mm.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_mode_config.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_mode_object.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_modeset_helper_vtables.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_modeset_lock.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_modes.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_panel.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_panic.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_plane.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_prime.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_print.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_privacy_screen_driver.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_privacy_screen_machine.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_property.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_rect.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_simple_kms_helper.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_syncobj.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_util.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_vblank.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_vblank_work.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_vma_manager.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/drm_writeback.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/gpu_scheduler.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/intel/i915_component.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/ttm/ttm_caching.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/ttm/ttm_device.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/ttm/ttm_placement.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/ttm/ttm_pool.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/ttm/ttm_resource.h
+./diff-doc -rst -enable-lineno -internal ./include/drm/ttm/ttm_tt.h
+./diff-doc -rst -enable-lineno -internal ./include/kunit/device.h
+./diff-doc -rst -enable-lineno -internal ./include/kunit/of.h
+./diff-doc -rst -enable-lineno -internal ./include/kunit/resource.h
+./diff-doc -rst -enable-lineno -internal ./include/kunit/static_stub.h
+./diff-doc -rst -enable-lineno -internal ./include/kunit/test.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/aperture.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/apple-gmux.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/atomic/atomic-arch-fallback.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/atomic/atomic-instrumented.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/atomic/atomic-long.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/backlight.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/bitmap.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/clk.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/completion.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/component.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/counter.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/dcache.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/debugobjects.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/dim.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/dma-buf.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/dma-fence-array.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/dma-fence-chain.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/dma-fence.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/dma-fence-unwrap.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/dma-resv.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/energy_model.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/err.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/etherdevice.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/fortify-string.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/fs.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/gpio/driver.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/hdmi.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/hrtimer.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/hsi/hsi.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/i2c.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/input.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/input/matrix_keypad.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/input/mt.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/input/sparse-keymap.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/interrupt.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/iosys-map.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/irq.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/jbd2.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/jiffies.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/kfifo.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/kgdb.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/kthread.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/ktime.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/libps2.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/list.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/log2.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/math64.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/mm.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/mm_types.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/module.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/mtd/rawnand.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/mutex.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/netdevice.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/net.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/of_device.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/of_graph.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/of.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/of_platform.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/overflow.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/pagemap.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/parport.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/phy.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/phylink.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/pipe_fs_i.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/platform_device.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/pstore_blk.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/pstore_zone.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/pwm.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/pwrseq/provider.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/refcount.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/regulator/consumer.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/regulator/driver.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/regulator/machine.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/reset-controller.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/reset.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/rio_drv.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/rio.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/rslib.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/sched.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/sfp.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/skbuff.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/slab.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/slimbus.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/spi/spi.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/string.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/sync_file.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/uio_driver.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/usb/composite.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/usb/gadget.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/usb.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/vgaarb.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/w1.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/wait.h
+./diff-doc -rst -enable-lineno -internal ./include/linux/wmi.h
+./diff-doc -rst -enable-lineno -internal ./include/media/v4l2-jpeg.h
+./diff-doc -rst -enable-lineno -internal ./include/net/net_shaper.h
+./diff-doc -rst -enable-lineno -internal ./include/net/sock.h
+./diff-doc -rst -enable-lineno -internal ./include/scsi/scsi_device.h
+./diff-doc -rst -enable-lineno -internal ./include/trace/events/block.h
+./diff-doc -rst -enable-lineno -internal ./include/trace/events/irq.h
+./diff-doc -rst -enable-lineno -internal ./include/trace/events/signal.h
+./diff-doc -rst -enable-lineno -internal ./include/trace/events/workqueue.h
+./diff-doc -rst -enable-lineno -internal ./include/uapi/drm/drm.h
+./diff-doc -rst -enable-lineno -internal ./include/uapi/drm/drm_mode.h
+./diff-doc -rst -enable-lineno -internal ./include/uapi/linux/cxl_mem.h
+./diff-doc -rst -enable-lineno -internal ./include/uapi/linux/firewire-cdev.h
+./diff-doc -rst -enable-lineno -internal ./include/uapi/linux/gen_stats.h
+./diff-doc -rst -enable-lineno -internal ./include/uapi/linux/sync_file.h
+./diff-doc -rst -enable-lineno -internal ./include/uapi/misc/xilinx_sdfec.h
+./diff-doc -rst -enable-lineno -internal ./ipc/util.c
+./diff-doc -rst -enable-lineno -internal ./kernel/acct.c
+./diff-doc -rst -enable-lineno -internal ./kernel/auditfilter.c
+./diff-doc -rst -enable-lineno -internal ./kernel/auditsc.c
+./diff-doc -rst -enable-lineno -internal ./kernel/exit.c
+./diff-doc -rst -enable-lineno -internal ./kernel/futex/core.c
+./diff-doc -rst -enable-lineno -internal ./kernel/futex/futex.h
+./diff-doc -rst -enable-lineno -internal ./kernel/futex/pi.c
+./diff-doc -rst -enable-lineno -internal ./kernel/futex/requeue.c
+./diff-doc -rst -enable-lineno -internal ./kernel/futex/waitwake.c
+./diff-doc -rst -enable-lineno -internal ./kernel/irq/chip.c
+./diff-doc -rst -enable-lineno -internal ./kernel/relay.c
+./diff-doc -rst -enable-lineno -internal ./kernel/resource.c
+./diff-doc -rst -enable-lineno -internal ./kernel/sched/cpupri.c
+./diff-doc -rst -enable-lineno -internal ./kernel/sched/fair.c
+./diff-doc -rst -enable-lineno -internal ./kernel/signal.c
+./diff-doc -rst -enable-lineno -internal ./kernel/trace/blktrace.c
+./diff-doc -rst -enable-lineno -internal ./lib/bitmap.c
+./diff-doc -rst -enable-lineno -internal ./net/tipc/bcast.c
+./diff-doc -rst -enable-lineno -internal ./net/tipc/bearer.c
+./diff-doc -rst -enable-lineno -internal ./net/tipc/bearer.h
+./diff-doc -rst -enable-lineno -internal ./net/tipc/crypto.c
+./diff-doc -rst -enable-lineno -internal ./net/tipc/discover.c
+./diff-doc -rst -enable-lineno -internal ./net/tipc/link.c
+./diff-doc -rst -enable-lineno -internal ./net/tipc/msg.c
+./diff-doc -rst -enable-lineno -internal ./net/tipc/name_distr.c
+./diff-doc -rst -enable-lineno -internal ./net/tipc/name_distr.h
+./diff-doc -rst -enable-lineno -internal ./net/tipc/name_table.c
+./diff-doc -rst -enable-lineno -internal ./net/tipc/name_table.h
+./diff-doc -rst -enable-lineno -internal ./net/tipc/node.c
+./diff-doc -rst -enable-lineno -internal ./net/tipc/socket.c
+./diff-doc -rst -enable-lineno -internal ./net/tipc/subscr.c
+./diff-doc -rst -enable-lineno -internal ./net/tipc/subscr.h
+./diff-doc -rst -enable-lineno -internal ./net/tipc/topsrv.c
+./diff-doc -rst -enable-lineno -internal ./net/tipc/trace.c
+./diff-doc -rst -enable-lineno -internal ./net/tipc/udp_media.c
+./diff-doc -rst -enable-lineno -internal -nosymbol device_link_state ./include/linux/device.h
+./diff-doc -rst -enable-lineno -internal -nosymbol i915_perf_init -nosymbol i915_perf_fini -nosymbol i915_perf_register -nosymbol i915_perf_unregister -nosymbol i915_perf_open_ioctl -nosymbol i915_perf_release -nosymbol i915_perf_add_config_ioctl -nosymbol i915_perf_remove_config_ioctl -nosymbol read_properties_unlocked -nosymbol i915_perf_open_ioctl_locked -nosymbol i915_perf_destroy_locked -nosymbol i915_perf_read -nosymbol i915_perf_ioctl -nosymbol i915_perf_enable_locked -nosymbol i915_perf_disable_locked -nosymbol i915_perf_poll -nosymbol i915_perf_poll_locked -nosymbol i915_oa_stream_init -nosymbol i915_oa_read -nosymbol i915_oa_stream_enable -nosymbol i915_oa_stream_disable -nosymbol i915_oa_wait_unlocked -nosymbol i915_oa_poll_wait ./drivers/gpu/drm/i915/i915_perf.c
+./diff-doc -rst -enable-lineno -internal -nosymbol kstrtol -nosymbol kstrtoul ./include/linux/kernel.h
+./diff-doc -rst -enable-lineno -internal -nosymbol mpcc_blnd_cfg -nosymbol mpcc_alpha_blend_mode ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+./diff-doc -rst -enable-lineno -internal -nosymbol pci_device_id ./include/linux/mod_devicetable.h
+./diff-doc -rst -enable-lineno -internal ./security/security.c
+./diff-doc -rst -enable-lineno ./kernel/irq/handle.c
+./diff-doc -rst -enable-lineno ./kernel/irq/irqdesc.c
+./diff-doc -rst -enable-lineno ./kernel/irq/manage.c
+./diff-doc -rst -enable-lineno ./kernel/padata.c
+./diff-doc -rst -enable-lineno ./kernel/rcu/srcutree.c
+./diff-doc -rst -enable-lineno ./kernel/rcu/sync.c
+./diff-doc -rst -enable-lineno ./kernel/rcu/tasks.h
+./diff-doc -rst -enable-lineno ./kernel/rcu/tree.c
+./diff-doc -rst -enable-lineno ./kernel/rcu/tree_exp.h
+./diff-doc -rst -enable-lineno ./kernel/rcu/tree_stall.h
+./diff-doc -rst -enable-lineno ./kernel/rcu/update.c
+./diff-doc -rst -enable-lineno ./kernel/trace/fprobe.c
+./diff-doc -rst -enable-lineno ./kernel/workqueue.c
+./diff-doc -rst -enable-lineno ./lib/bootconfig.c
+./diff-doc -rst -enable-lineno ./lib/crc32.c
+./diff-doc -rst -enable-lineno ./lib/errseq.c
+./diff-doc -rst -enable-lineno ./lib/maple_tree.c
+./diff-doc -rst -enable-lineno ./lib/xarray.c
+./diff-doc -rst -enable-lineno ./mm/balloon_compaction.c
+./diff-doc -rst -enable-lineno ./mm/damon/core.c
+./diff-doc -rst -enable-lineno ./mm/highmem.c
+./diff-doc -rst -enable-lineno ./mm/huge_memory.c
+./diff-doc -rst -enable-lineno ./mm/hugetlb.c
+./diff-doc -rst -enable-lineno ./mm/io-mapping.c
+./diff-doc -rst -enable-lineno ./mm/kmemleak.c
+./diff-doc -rst -enable-lineno ./mm/maccess.c
+./diff-doc -rst -enable-lineno ./mm/mapping_dirty_helpers.c
+./diff-doc -rst -enable-lineno ./mm/memcontrol.c
+./diff-doc -rst -enable-lineno ./mm/memory_hotplug.c
+./diff-doc -rst -enable-lineno ./mm/mempolicy.c
+./diff-doc -rst -enable-lineno ./mm/memremap.c
+./diff-doc -rst -enable-lineno ./mm/migrate.c
+./diff-doc -rst -enable-lineno ./mm/migrate_device.c
+./diff-doc -rst -enable-lineno ./mm/mmap.c
+./diff-doc -rst -enable-lineno ./mm/mmu_notifier.c
+./diff-doc -rst -enable-lineno ./mm/page_alloc.c
+./diff-doc -rst -enable-lineno ./mm/percpu.c
+./diff-doc -rst -enable-lineno ./mm/rmap.c
+./diff-doc -rst -enable-lineno ./mm/shmem.c
+./diff-doc -rst -enable-lineno ./mm/swap.c
+./diff-doc -rst -enable-lineno ./mm/vmscan.c
+./diff-doc -rst -enable-lineno ./mm/zpool.c
+./diff-doc -rst -enable-lineno ./mm/zsmalloc.c
+./diff-doc -rst -enable-lineno -no-doc-sections ./drivers/cxl/core/cdat.c
+./diff-doc -rst -enable-lineno -no-doc-sections ./drivers/cxl/core/hdm.c
+./diff-doc -rst -enable-lineno -no-doc-sections ./drivers/cxl/core/memdev.c
+./diff-doc -rst -enable-lineno -no-doc-sections ./drivers/cxl/core/pci.c
+./diff-doc -rst -enable-lineno -no-doc-sections ./drivers/cxl/core/port.c
+./diff-doc -rst -enable-lineno -no-doc-sections ./drivers/cxl/core/region.c
+./diff-doc -rst -enable-lineno -no-doc-sections ./drivers/misc/mei/hdcp/mei_hdcp.c
+./diff-doc -rst -enable-lineno -no-doc-sections ./include/linux/generic-radix-tree.h
+./diff-doc -rst -enable-lineno -no-doc-sections ./include/linux/idr.h
+./diff-doc -rst -enable-lineno -no-doc-sections ./lib/idr.c
+./diff-doc -rst -enable-lineno -no-doc-sections ./mm/memblock.c
+./diff-doc -rst -enable-lineno -no-doc-sections ./security/landlock/fs.h
+./diff-doc -rst -enable-lineno -no-doc-sections ./security/landlock/object.h
+./diff-doc -rst -enable-lineno -no-doc-sections ./security/landlock/ruleset.h
+./diff-doc -rst -enable-lineno -nosymbol bus_type -nosymbol bus_notifier_event ./include/linux/device/bus.h
+./diff-doc -rst -enable-lineno -nosymbol class ./include/linux/device/class.h
+./diff-doc -rst -enable-lineno -nosymbol probe_type -nosymbol device_driver ./include/linux/device/driver.h
+./diff-doc -rst -enable-lineno ./sound/core/compress_offload.c
+./diff-doc -rst -enable-lineno ./sound/core/control.c
+./diff-doc -rst -enable-lineno ./sound/core/device.c
+./diff-doc -rst -enable-lineno ./sound/core/hwdep.c
+./diff-doc -rst -enable-lineno ./sound/core/info.c
+./diff-doc -rst -enable-lineno ./sound/core/init.c
+./diff-doc -rst -enable-lineno ./sound/core/isadma.c
+./diff-doc -rst -enable-lineno ./sound/core/jack.c
+./diff-doc -rst -enable-lineno ./sound/core/memalloc.c
+./diff-doc -rst -enable-lineno ./sound/core/memory.c
+./diff-doc -rst -enable-lineno ./sound/core/pcm.c
+./diff-doc -rst -enable-lineno ./sound/core/pcm_dmaengine.c
+./diff-doc -rst -enable-lineno ./sound/core/pcm_lib.c
+./diff-doc -rst -enable-lineno ./sound/core/pcm_memory.c
+./diff-doc -rst -enable-lineno ./sound/core/pcm_misc.c
+./diff-doc -rst -enable-lineno ./sound/core/pcm_native.c
+./diff-doc -rst -enable-lineno ./sound/core/rawmidi.c
+./diff-doc -rst -enable-lineno ./sound/core/sound.c
+./diff-doc -rst -enable-lineno ./sound/core/vmaster.c
+./diff-doc -rst -enable-lineno ./sound/drivers/mpu401/mpu401_uart.c
+./diff-doc -rst -enable-lineno ./sound/pci/ac97/ac97_codec.c
+./diff-doc -rst -enable-lineno ./sound/pci/ac97/ac97_pcm.c
+./diff-doc -rst -enable-lineno ./sound/soc/soc-component.c
+./diff-doc -rst -enable-lineno ./sound/soc/soc-compress.c
+./diff-doc -rst -enable-lineno ./sound/soc/soc-core.c
+./diff-doc -rst -enable-lineno ./sound/soc/soc-dapm.c
+./diff-doc -rst -enable-lineno ./sound/soc/soc-devres.c
+./diff-doc -rst -enable-lineno ./sound/soc/soc-generic-dmaengine-pcm.c
+./diff-doc -rst -enable-lineno ./sound/soc/soc-jack.c
+./diff-doc -rst -enable-lineno ./sound/soc/soc-ops.c
+./diff-doc -rst -enable-lineno ./sound/soc/soc-pcm.c
+./diff-doc -rst -enable-lineno ./sound/sound_core.c
diff --git a/diff-doc b/diff-doc
new file mode 100755
index 000000000000..3cce8bb25c04
--- /dev/null
+++ b/diff-doc
@@ -0,0 +1,59 @@
+#!/bin/bash
+
+RST=
+MAN=
+ARGS=
+
+args=()
+
+while [ "$1" != "" ]; do
+        case $1 in
+        --rst|-rst)
+                RST=1
+                ;;
+	# For now, ignore line numbers
+        --enable-lineno|-enable-lineno)
+                ;;
+        --man|-man)
+                MAN=1
+                ;;
+        *)
+		args+=(${1@Q})
+                ;;
+        esac
+        shift
+done
+
+if [ -z "$args" ]; then
+	echo "Need a filename"
+	exit 1
+fi
+
+if [ -z $RST ]; then
+	if [ -z $MAN ]; then
+		RST=1
+	fi
+fi
+
+echo >org
+echo >new
+
+echo scripts/kernel-doc ${args[@]}
+
+if [ ! -z $MAN ]; then
+	eval ./scripts/kernel-doc.pl -man ${args[@]} >>org
+fi
+
+if [ ! -z $RST ]; then
+	eval ./scripts/kernel-doc.pl -rst ${args[@]} >>org
+fi
+
+if [ ! -z $MAN ]; then
+	eval ./scripts/kernel-doc.py -man ${args[@]} >>new
+fi
+
+if [ ! -z $RST ]; then
+	eval ./scripts/kernel-doc.py -rst ${args[@]} >>new
+fi
+
+diff -u -B org new





Thanks,
Mauro

