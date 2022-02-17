Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11C04BA8BD
	for <lists+linux-arch@lfdr.de>; Thu, 17 Feb 2022 19:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244618AbiBQSuH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Feb 2022 13:50:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiBQSuG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2022 13:50:06 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24E45133D;
        Thu, 17 Feb 2022 10:49:50 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id i11so9656334eda.9;
        Thu, 17 Feb 2022 10:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1KLsOXFQmHt2Ndcx44uMZzlDaAUhgjoshtkxgzU1bcE=;
        b=m6sS5ABWEL2d8zqr78X8sQTm1wLF4+wr0yfKJtR9BQASzlk3S+wf7qI5SsghWBYpES
         fIPaOCiTe01gLceW2tOW6HmX7nZynH9u5lqDqjmmLGkvGmv+kgeIZsjQ5mquBNmOuj37
         HBKutI6wjWB01Dd8kpei7/oA0QoKoWWKxF08G7NBSka0UWTQAJtSiY9wVoWdbwCs/e6Y
         aTR6/mQSrSIP8fEoAhr1mFXPks8VDtUcZvFdBVZ9qYtHeexNf16vwMPImYxKq9JriClY
         r90k3fGEbniaVaRS/Qd0D1xrnRGmJ0iitYIx0ul6TLki5M5rydrACwJTDKDIiMX5RfpO
         EDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1KLsOXFQmHt2Ndcx44uMZzlDaAUhgjoshtkxgzU1bcE=;
        b=b7Ij8/m0vvOZudZ+7RyUnmCFCfDoWfwMABEp8g8x6yKTyBhYDJZDQc5XLIkR9pP5Dz
         41KedFsMO8foMobfZaCR68saQiNsG4BiP2ePIQ2ef3OxDpGDFWKc0ymKN15WPxou0mPw
         0ow/j4LlnsgQXr0ZFvsoObKwSron0hdQKHo/n/407nfpyvsxkBmuYVIKuunzuJS225OK
         W2cZq7gOXqL5EzuAzAqUZ8lz4djDSCHsZVT+jn72XFSOo89LHnTZxK1KqRQcYBxTnJbh
         dq5lDiA028NRhr8fu+WrDx9OYefA9ktw1KPEwZmhx/45VYYs87owIC3rcLTaPGBSxnUQ
         MgZA==
X-Gm-Message-State: AOAM531hR4qaO8+O27q8W+Cdm6kUE/z3Q40i7d8vWXJiqkaAk79SIiB3
        hm7p5zNZAl+csIZQv5Tb7n4=
X-Google-Smtp-Source: ABdhPJx57ErqeoSoN1HNG4bKqWqmerC0ClES8rpEmtzCOWCMeGyDp900eCjZISw8zvTbT1icmyJZig==
X-Received: by 2002:a05:6402:2922:b0:40f:7241:74d4 with SMTP id ee34-20020a056402292200b0040f724174d4mr4230943edb.43.1645123789005;
        Thu, 17 Feb 2022 10:49:49 -0800 (PST)
Received: from localhost.localdomain (dhcp-077-250-038-153.chello.nl. [77.250.38.153])
        by smtp.googlemail.com with ESMTPSA id q7sm3493268edv.93.2022.02.17.10.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 10:49:48 -0800 (PST)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergman <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [RFC PATCH 00/13] Proposal for speculative safe list iterator
Date:   Thu, 17 Feb 2022 19:48:16 +0100
Message-Id: <20220217184829.1991035-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Kasper (https://vusec.net/projects/kasper/) has shown that using the
list_for_each_entry() iterator is security critical with transient
execution in mind.

list_for_each_entry() iterates through a list until the terminating
condition is met where pos, the iterator value, reaches the head element.
The head is usually not within the struct of the list elements and either
stands on its own or is included within a struct of an other type.
Therefore using `container_of` on the head element to retrieve the iterator
value is invalid and therefore a type confusion.

If the terminating condition does not hold in transient execution and is
mispredicted, the iterator infered from the head is used in the additional
transient iteration of the loop body. Depending on the struct members
accessed within the loop an attacker can inject own values turning it into
a transient gadget. In the paper we have showed such a case in
find_keyring_by_name().

We patched list_for_each_entry() to ensure that pos is not pointing to an
invalid head element in the transient iteration of the loop. It uses
branchless logic to set pos to NULL when the terminating condition is met,
making it unusable in transient execution.

Unfortunately there are several locations in the kernel where the list
iterator is used after the loop that break with such a change. Luckily
there is the use_after_iter.cocci script that can be used to identify such
code locations. I had to adapt the script slightly since it reduces false
positives in the original use case but those are relevant for this patch.

A large range of reported code locations only use the list iterator after
the loop if there was an early exit (break/goto) and are therefore not
relevant.

However there is still ~200 occurrences that would break with the nospec
implementation of list_for_each_entry().

I have categorized them into certain categories where some are more trivial
to patch than others. I have included reference patches for the first case
of the categories that are trivial or almost trivial to patch. When
everything is clear I will go through the list to fix the other cases
according to the reference patch.

head pos will reference to the case where pos is not actually pointing to
the element of the list but is derived from the head.

I'd especially appreciate comments on how to deal with category 10.
For those cases it is not clear that head pos is not used incorrectly. It
either relies on implict constraints that ensure that the list iteration
exits early or is an actual bug.
Since non of those cases should use pos if the break was not hit they
should not be affected by the speculative list iterator.
I just want to make sure, since changing the list iterator will turn them
from a type confusion into a null pointer dereference (+ some offset
depending on the struct member).

All line numbers are based on commit f71077a4d84bbe8c7b91b7db7c4ef815755ac5e3.


Category 1: &pos->other_member is used to determine if a certain element was found
drivers/usb/gadget/udc/gr_udc.c:1717
drivers/usb/gadget/udc/net2280.c:1273
drivers/usb/gadget/udc/atmel_usba_udc.c:877
drivers/usb/gadget/udc/lpc32xx_udc.c:1847
drivers/usb/gadget/udc/pxa25x_udc.c:983
drivers/usb/gadget/udc/aspeed-vhub/epn.c:481
drivers/usb/gadget/udc/fsl_qe_udc.c:1793
drivers/usb/gadget/udc/net2272.c:946
drivers/usb/gadget/udc/s3c-hsudc.c:893
drivers/usb/gadget/udc/mv_udc_core.c:800
drivers/usb/gadget/udc/at91_udc.c:724
drivers/usb/gadget/udc/mv_u3d_core.c:868
drivers/usb/gadget/udc/udc-xilinx.c:1149
drivers/usb/gadget/udc/bdc/bdc_ep.c:1779
drivers/usb/gadget/udc/fsl_udc_core.c:947
drivers/usb/gadget/udc/omap_udc.c:1019

Category 2: pos is used to determine if a certain element was found
drivers/vfio/mdev/mdev_core.c:349
drivers/usb/gadget/udc/tegra-xudc.c:1427
drivers/usb/gadget/udc/max3420_udc.c:1062
drivers/thermal/thermal_core.c:1085
drivers/thermal/thermal_core.c:645
drivers/thermal/thermal_core.c:1349
drivers/usb/gadget/configfs.c:435
drivers/usb/gadget/configfs.c:893
drivers/usb/mtu3/mtu3_gadget.c:343
drivers/usb/musb/musb_gadget.c:1285
arch/x86/kernel/cpu/sgx/encl.c:466
drivers/scsi/scsi_transport_sas.c:1075

Category 3: pos is used to determine if the list is empty (shouldn't need fixing)
drivers/perf/xgene_pmu.c:1487
drivers/media/pci/saa7134/saa7134-alsa.c:1232
arch/powerpc/sysdev/fsl_gtm.c:106
drivers/staging/greybus/audio_helper.c:135
drivers/misc/fastrpc.c:1363
drivers/dma/ppc4xx/adma.c:3048
drivers/dma/ppc4xx/adma.c:3060

Category 4: pos is used to determine if the break/goto was hit and the list is not empty
arch/arm/mach-mmp/sram.c:54
arch/arm/plat-pxa/ssp.c:54
arch/arm/plat-pxa/ssp.c:78
drivers/block/drbd/drbd_req.c:344
drivers/block/drbd/drbd_req.c:370
drivers/block/drbd/drbd_req.c:396
drivers/counter/counter-chrdev.c:145
drivers/counter/counter-chrdev.c:555
drivers/crypto/cavium/nitrox/nitrox_main.c:280
drivers/dma/ppc4xx/adma.c:954
drivers/firewire/core-transaction.c:93
drivers/firewire/core-transaction.c:963
drivers/firewire/sbp2.c:446
drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:2458
drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:2466
drivers/gpu/drm/drm_memory.c:79
drivers/gpu/drm/drm_mm.c:938
drivers/gpu/drm/drm_vm.c:160
drivers/gpu/drm/i915/gem/i915_gem_context.c:128
drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:2471
drivers/gpu/drm/i915/gt/intel_ring.c:211
drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c:1168
drivers/gpu/drm/panfrost/panfrost_mmu.c:200
drivers/gpu/drm/scheduler/sched_main.c:1111
drivers/gpu/drm/ttm/ttm_bo.c:702
drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:2600
drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:2624
drivers/infiniband/hw/hfi1/tid_rdma.c:1280
drivers/infiniband/hw/hfi1/tid_rdma.c:1280
drivers/infiniband/hw/mlx4/main.c:1933
drivers/media/dvb-frontends/mxl5xx.c:505
drivers/media/v4l2-core/v4l2-ctrls-api.c:1002
drivers/media/v4l2-core/v4l2-ctrls-api.c:986
drivers/misc/mei/interrupt.c:432
drivers/net/ethernet/mellanox/mlx4/alloc.c:273
drivers/net/ethernet/mellanox/mlx4/alloc.c:273
drivers/net/wireless/intel/ipw2x00/libipw_rx.c:1569
drivers/scsi/lpfc/lpfc_bsg.c:1218
drivers/staging/rtl8192e/rtl819x_TSProc.c:256
drivers/staging/rtl8192e/rtllib_rx.c:2638
drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c:2370
drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c:255
drivers/usb/gadget/composite.c:2050
fs/proc/kcore.c:495
kernel/power/snapshot.c:637
kernel/power/snapshot.c:637
kernel/trace/ftrace.c:4570
kernel/trace/ftrace.c:4722
kernel/trace/trace_events.c:2285

drivers/net/ethernet/qlogic/qede/qede_filter.c:843
drivers/gpu/drm/gma500/oaktrail_lvds.c:120
drivers/power/supply/cpcap-battery.c:802
fs/cifs/smb2misc.c:161
kernel/debug/kdb/kdb_main.c:1031
kernel/debug/kdb/kdb_main.c:1038
kernel/debug/kdb/kdb_main.c:795
kernel/trace/trace_eprobe.c:670
net/9p/trans_xen.c:131
net/xfrm/xfrm_ipcomp.c:244
sound/soc/intel/catpt/pcm.c:362
sound/soc/sprd/sprd-mcdt.c:880

Category 5: legitimately uses head pos for cmp
net/ipv4/udp_tunnel_nic.c:849
drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c:487
drivers/scsi/wd719x.c:691
fs/f2fs/segment.c:368
net/tipc/socket.c:3752
net/tipc/name_table.c:970

Category 6: legitimately uses pos->member
drivers/net/dsa/sja1105/sja1105_vl.c:43
drivers/staging/android/ashmem.c:730
net/core/gro.c:38
fs/fs-writeback.c:437
mm/hugetlb.c:446
mm/compaction.c:1473
fs/locks.c:1130
drivers/net/ethernet/mellanox/mlx4/alloc.c:373
drivers/dma/at_xdmac.c:1583

arch/arm/mm/ioremap.c:107
arch/x86/kvm/mtrr.c:368
block/blk-mq.c:4466
drivers/dma/mv_xor.c:316
drivers/dma/mv_xor_v2.c:366
drivers/gpu/drm/nouveau/nvkm/core/mm.c:77
drivers/gpu/drm/nouveau/nvkm/subdev/timer/base.c:127
drivers/infiniband/hw/usnic/usnic_uiom.c:527
drivers/iommu/iommu.c:448
drivers/iommu/virtio-iommu.c:509
drivers/irqchip/irq-gic-v3-its.c:2093
drivers/md/dm-snap.c:542
drivers/net/ethernet/mellanox/mlx4/alloc.c:393
drivers/net/ethernet/sfc/rx_common.c:601
drivers/net/ethernet/ti/netcp_core.c:491
drivers/net/ethernet/ti/netcp_core.c:491
drivers/net/ethernet/ti/netcp_core.c:540
drivers/net/ethernet/ti/netcp_core.c:540
drivers/nvdimm/namespace_devs.c:1933
drivers/s390/char/tape_core.c:349
drivers/s390/cio/cmf.c:469
drivers/scsi/fcoe/fcoe.c:1885
drivers/scsi/lpfc/lpfc_sli.c:3498
drivers/target/target_core_user.c:400
drivers/usb/host/uhci-q.c:463
rivers/video/fbdev/core/fb_defio.c:139
drivers/xen/events/events_base.c:602
fs/dlm/lock.c:1315
fs/dlm/lock.c:1315
fs/f2fs/segment.c:4185
fs/locks.c:1238
fs/locks.c:1250
kernel/padata.c:397
kernel/trace/trace_output.c:717
net/tipc/group.c:392
net/tipc/monitor.c:416
sound/core/seq/seq_ports.c:152
sound/core/timer.c:1052


drivers/block/drbd/drbd_main.c:230
fs/locks.c:1130
drivers/gpu/drm/vc4/vc4_dsi.c:768

drivers/dma/ppc4xx/adma.c:2733
drivers/iio/industrialio-buffer.c:1128
drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c:535
drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c:655
drivers/net/ipvlan/ipvlan_main.c:47
drivers/staging/media/atomisp/pci/atomisp_acc.c:514
fs/gfs2/lops.c:681
fs/gfs2/lops.c:696
kernel/padata.c:656
net/netfilter/nf_tables_api.c:8291


arch/powerpc/platforms/cell/spufs/sched.c:387
drivers/dma/ppc4xx/adma.c:1436


drivers/net/wireless/ath/ath6kl/htc_mbox.c:107
drivers/dma/dw-edma/dw-edma-core.c:139
drivers/dma/dw-edma/dw-edma-core.c:159
drivers/net/ethernet/intel/i40e/i40e_ethtool.c:3966
drivers/scsi/lpfc/lpfc_sli.c:21042


drivers/net/ethernet/intel/ice/ice_sched.c:2808
drivers/net/ethernet/intel/ice/ice_sched.c:2811
drivers/net/wireless/st/cw1200/queue.c:120
arch/powerpc/kvm/book3s_hv_uvmem.c:370
drivers/gpu/drm/tilcdc/tilcdc_external.c:69
drivers/gpu/drm/stm/ltdc.c:559
sound/isa/cs423x/cs4236.c:520
drivers/media/usb/uvc/uvc_v4l2.c:896
drivers/iommu/msm_iommu.c:627

drivers/firmware/stratix10-svc.c:953
drivers/opp/debugfs.c:200

drivers/md/dm-mpath.c:1503
drivers/dma/ppc4xx/adma.c:3071
drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c:111
drivers/net/wireless/ath/ath10k/mac.c:510
drivers/s390/char/tty3270.c:1151
drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c:281

drivers/net/ethernet/intel/i40e/i40e_main.c:7590
drivers/staging/media/atomisp/pci/atomisp_cmd.c:959
drivers/staging/media/atomisp/pci/atomisp_cmd.c:979
drivers/staging/media/atomisp/pci/atomisp_cmd.c:998
drivers/watchdog/watchdog_pretimeout.c:215
fs/jfs/jfs_logmgr.c:892
kernel/workqueue.c:2946
drivers/media/usb/uvc/uvc_v4l2.c:885
drivers/gpu/drm/gma500/oaktrail_crtc.c:428
drivers/virt/acrn/ioreq.c:243
drivers/net/ethernet/mellanox/mlx5/core/eq.c:986
drivers/gpu/drm/omapdrm/omap_encoder.c:109
drivers/scsi/dc395x.c:3598
drivers/staging/media/atomisp/pci/atomisp_acc.c:508

drivers/net/dsa/bcm_sf2_cfp.c:577
drivers/perf/qcom_l2_pmu.c:764
drivers/gpu/drm/gma500/psb_intel_display.c:545
drivers/firmware/efi/vars.c:1092


drivers/staging/greybus/audio_codec.c:603
drivers/scsi/mpt3sas/mpt3sas_base.c:2016

Jakob Koschel (13):
  list: introduce speculative safe list_for_each_entry()
  scripts: coccinelle: adapt to find list_for_each_entry nospec issues
  usb: remove the usage of the list iterator after the loop
  vfio/mdev: remove the usage of the list iterator after the loop
  drivers/perf: remove the usage of the list iterator after the loop
  ARM: mmp: remove the usage of the list iterator after the loop
  udp_tunnel: remove the usage of the list iterator after the loop
  net: dsa: future proof usage of list iterator after the loop
  drbd: future proof usage of list iterator after the loop
  powerpc/spufs: future proof usage of list iterator after the loop
  ath6kl: remove use of list iterator after the loop
  staging: greybus: audio: Remove usage of list iterator after the loop
  scsi: mpt3sas: comment about invalid usage of the list iterator

 arch/arm/mach-mmp/sram.c                      |  7 ++++--
 arch/powerpc/platforms/cell/spufs/sched.c     |  2 ++
 arch/x86/include/asm/barrier.h                | 12 ++++++++++
 drivers/block/drbd/drbd_main.c                |  2 ++
 drivers/net/dsa/sja1105/sja1105_vl.c          |  2 ++
 drivers/net/wireless/ath/ath6kl/htc_mbox.c    |  2 +-
 drivers/perf/xgene_pmu.c                      |  5 ++--
 drivers/scsi/mpt3sas/mpt3sas_base.c           |  2 +-
 drivers/staging/greybus/audio_codec.c         |  4 ++--
 drivers/usb/gadget/udc/gr_udc.c               |  7 ++++--
 drivers/vfio/mdev/mdev_core.c                 |  7 ++++--
 include/linux/list.h                          |  3 ++-
 include/linux/nospec.h                        | 16 +++++++++++++
 net/ipv4/udp_tunnel_nic.c                     |  7 ++++--
 .../coccinelle/iterators/use_after_iter.cocci | 24 -------------------
 15 files changed, 63 insertions(+), 39 deletions(-)


base-commit: f71077a4d84bbe8c7b91b7db7c4ef815755ac5e3
--
2.25.1

