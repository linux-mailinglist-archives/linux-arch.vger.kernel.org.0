Return-Path: <linux-arch+bounces-3396-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B125A8974A6
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 17:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61C64294FBE
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 15:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A2E14A4FC;
	Wed,  3 Apr 2024 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O2Mn63bj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9362F32;
	Wed,  3 Apr 2024 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159814; cv=none; b=dnmssQydSSVMyOlJrsPCvrbUJoJLKDcduBfgu3vGKcdosbzJw7r5BoBB7W4XIBChW+HeGXKs7FVNE5LuGz/K0FAZbGE2PZvdM5fd+/dcHTht70k4+4lhGtc63FgqugWo9M1j/plGO8/a+jQIAwhu0VW6151t5nZgKCd9vACXrFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159814; c=relaxed/simple;
	bh=M5+8GBjoVDuWpOeM/mPu35USnUmQ8I2/wxrTMt3H7Os=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jDiAjYarKTc5dlibhIwoNWitCEai4m5I83qMVJh2+RYv+9S+YJvvd2jdcQeRARXM1orbzA06LVhJNP+GhS4JsDqaEkXJDyTZkZ5CmxvA/+O2jDbbFpm5fXaKRwTpOQBRlM9G75upiNmr7W0b+OAO+8yqlWKGq9a4p8KKaqLL8CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O2Mn63bj; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712159810; x=1743695810;
  h=date:from:to:cc:subject:message-id;
  bh=M5+8GBjoVDuWpOeM/mPu35USnUmQ8I2/wxrTMt3H7Os=;
  b=O2Mn63bjAOdNogSFJO708kzEoU0A0jM0Xl71U/A0z2Po60RfAVxDwxP/
   8uNrqx8M0rK06rjKoX2h6WWrn81MWwHs+tp3+i9WbX3YqD0B4OE8U9N+Z
   uv7uYu2KIjxz2znCF61j52lyvnNrIM+pgDgOOqBq6JNRc7h0ZyOvvW1xV
   CAwx6jUciAUsWi1/06KhKzeErHTy0s1Z0kdD8L4Fbevrhm0ptXSIz2YBC
   4ZjCUTV0wT8wgLQvDt3sAkVcTFC3bF7ASXp8lhkxGHkybKTo14mMfTxNa
   48U3e+hinRUcxwjiKhjg0nZXM0XibVGJ8si6HKEyo84NNDEgTJRXRRAdJ
   g==;
X-CSE-ConnectionGUID: 8eFPL8o/R7avJK2e2WSi1w==
X-CSE-MsgGUID: zd4vGzJiQDqqNCd31S3J1A==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="24903565"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="24903565"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 08:56:49 -0700
X-CSE-ConnectionGUID: bUQU2dzgQiS1Pliu3Kw6EA==
X-CSE-MsgGUID: qc4a1F6mStuCMFjp+IjsMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="22975428"
Received: from lkp-server02.sh.intel.com (HELO 90ee3aa53dbd) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 03 Apr 2024 08:56:44 -0700
Received: from kbuild by 90ee3aa53dbd with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rs2yX-0002Nd-0u;
	Wed, 03 Apr 2024 15:56:35 +0000
Date: Wed, 03 Apr 2024 23:56:30 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, kasan-dev@googlegroups.com,
 lima@lists.freedesktop.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-sound@vger.kernel.org,
 nouveau@lists.freedesktop.org, samba-technical@lists.samba.org
Subject: [linux-next:master] BUILD REGRESSION
 727900b675b749c40ba1f6669c7ae5eb7eb8e837
Message-ID: <202404032326.KpdXGGKv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 727900b675b749c40ba1f6669c7ae5eb7eb8e837  Add linux-next specific files for 20240403

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202404031246.aq5Yr5KO-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202404031346.wpIhNpyF-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202404032101.sKzRXCWH-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

fs/smb/client/file.c:728:12: warning: variable 'rc' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
mm/kasan/hw_tags.c:280:14: warning: assignment to 'struct vm_struct *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
mm/kasan/hw_tags.c:280:16: error: implicit declaration of function 'find_vm_area'; did you mean 'find_vma_prev'? [-Werror=implicit-function-declaration]
mm/kasan/hw_tags.c:284:29: error: invalid use of undefined type 'struct vm_struct'
riscv32-linux-ld: section .data LMA [001f9000,009465d7] overlaps section .text LMA [000a7e84,0177d68b]

Unverified Error/Warning (likely false positive, please contact us if interested):

fs/smb/client/file.c:619 serverclose_work() error: uninitialized symbol 'rc'.
fs/smb/client/file.c:732 _cifsFileInfo_put() error: uninitialized symbol 'rc'.

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- alpha-defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm-aspeed_g5_defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm-randconfig-001-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm-randconfig-002-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm-randconfig-004-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm-randconfig-r061-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm64-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm64-defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm64-randconfig-003-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm64-randconfig-r011-20220710
|   |-- mm-kasan-hw_tags.c:error:implicit-declaration-of-function-find_vm_area
|   |-- mm-kasan-hw_tags.c:error:invalid-use-of-undefined-type-struct-vm_struct
|   `-- mm-kasan-hw_tags.c:warning:assignment-to-struct-vm_struct-from-int-makes-pointer-from-integer-without-a-cast
|-- arm64-randconfig-r064-20240403
|   |-- drivers-firmware-arm_scmi-raw_mode.c:WARNING:scmi_dbg_raw_mode_reset_fops:write()-has-stream-semantic-safe-to-change-nonseekable_open-stream_open.
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- csky-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- csky-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- csky-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- csky-defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- csky-randconfig-001-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- csky-randconfig-002-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-allmodconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-allyesconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-buildonly-randconfig-001-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-buildonly-randconfig-005-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-001-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-003-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-004-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-006-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-011-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-013-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-015-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-051-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-053-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-061-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-062-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-063-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- loongarch-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- loongarch-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- loongarch-defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- loongarch-randconfig-001-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- loongarch-randconfig-002-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- m68k-allmodconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- m68k-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- m68k-allyesconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- m68k-defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- m68k-m5307c3_defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- m68k-randconfig-r053-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- microblaze-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- microblaze-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- microblaze-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- microblaze-defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- microblaze-randconfig-r122-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- mips-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- mips-allyesconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- mips-loongson3_defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- nios2-allmodconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- nios2-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- nios2-allyesconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- nios2-defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- nios2-randconfig-001-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- nios2-randconfig-002-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- nios2-randconfig-r131-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- nios2-randconfig-r133-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- openrisc-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- openrisc-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- openrisc-defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- openrisc-randconfig-r111-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- powerpc-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- powerpc-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- powerpc-mpc837x_rdb_defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- powerpc-mvme5100_defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- powerpc-ppc64e_defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- powerpc-randconfig-001-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- powerpc-randconfig-002-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- powerpc-randconfig-r121-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- powerpc64-randconfig-001-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- powerpc64-randconfig-003-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- riscv-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- riscv-randconfig-r032-20221115
|   `-- riscv32-linux-ld:section-.data-LMA-001f9465d7-overlaps-section-.text-LMA-000a7e7d68b
|-- riscv-randconfig-r112-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- s390-alldefconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- s390-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- s390-randconfig-r052-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- s390-randconfig-r123-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- sparc-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- sparc-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- sparc-defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- sparc-randconfig-001-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- sparc-randconfig-002-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- sparc-randconfig-r051-20240403
|   |-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- sparc64-allmodconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- sparc64-allyesconfig
|   |-- drivers-gpu-drm-imx-ipuv3-imx-ldb.c:error:_sel-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|   |-- drivers-gpu-drm-nouveau-nouveau_backlight.c:error:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- sparc64-defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- sparc64-randconfig-001-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- sparc64-randconfig-002-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- um-allyesconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- um-i386_defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- um-randconfig-001-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-buildonly-randconfig-001-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-buildonly-randconfig-002-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-buildonly-randconfig-004-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-buildonly-randconfig-006-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-001-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-003-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-004-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-005-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-011-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-012-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-013-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-014-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-015-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-016-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-072-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-074-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-075-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-076-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-101-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-102-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|   `-- sound-soc-codecs-rk3308_codec.c:warning:rk3308_codec_of_match-defined-but-not-used
|-- x86_64-randconfig-103-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-104-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-122-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-161-20240403
|   |-- drivers-pinctrl-pinctrl-aw9523.c-aw9523_gpio_get_multiple()-error:uninitialized-symbol-ret-.
|   |-- drivers-pinctrl-pinctrl-aw9523.c-aw9523_pconf_set()-error:uninitialized-symbol-rc-.
|   |-- fs-smb-client-file.c-_cifsFileInfo_put()-error:uninitialized-symbol-rc-.
|   |-- fs-smb-client-file.c-serverclose_work()-error:uninitialized-symbol-rc-.
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- xtensa-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- xtensa-randconfig-001-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- xtensa-randconfig-002-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
`-- xtensa-randconfig-r062-20240403
    |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
    `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
clang_recent_errors
|-- arm-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm-defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm-imx_v6_v7_defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm-pxa168_defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm-randconfig-003-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-irq-dce110-irq_service_dce110.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_ddi.c:error:arithmetic-between-different-enumeration-types-(-enum-hpd_pin-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-tc_port-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-msm-adreno-a6xx_gpu_state.c:error:variable-out-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-panthor-panthor_sched.c:error:variable-csg_mod_mask-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-renesas-rcar-du-rcar_cmm.c:error:unused-function-rcar_cmm_read-Werror-Wunused-function
|   |-- fs-smb-client-file.c:warning:variable-rc-is-used-uninitialized-whenever-if-condition-is-false
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm64-randconfig-001-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm64-randconfig-002-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- arm64-randconfig-004-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- hexagon-allmodconfig
|   |-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- hexagon-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- hexagon-allyesconfig
|   |-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- hexagon-defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- hexagon-randconfig-001-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- hexagon-randconfig-002-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- hexagon-randconfig-r063-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-buildonly-randconfig-002-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-buildonly-randconfig-003-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-buildonly-randconfig-004-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-buildonly-randconfig-006-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-002-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-005-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-012-20240403
|   |-- fs-smb-client-file.c:warning:variable-rc-is-used-uninitialized-whenever-if-condition-is-false
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-014-20240403
|   |-- fs-smb-client-file.c:warning:variable-rc-is-used-uninitialized-whenever-if-condition-is-false
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-016-20240403
|   |-- fs-smb-client-file.c:warning:variable-rc-is-used-uninitialized-whenever-if-condition-is-false
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-052-20240403
|   |-- fs-smb-client-file.c:warning:variable-rc-is-used-uninitialized-whenever-if-condition-is-false
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-054-20240403
|   |-- fs-smb-client-file.c:warning:variable-rc-is-used-uninitialized-whenever-if-condition-is-false
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-141-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- i386-randconfig-r132-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- mips-bcm63xx_defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- mips-mtx1_defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- powerpc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-msm-adreno-a6xx_gpu_state.c:error:variable-out-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-nouveau-nvkm-subdev-bios-shadowof.c:error:cast-from-void-(-)(const-void-)-to-void-(-)(void-)-converts-to-incompatible-function-type-Werror-Wcast-function-type-strict
|   |-- drivers-gpu-drm-panthor-panthor_sched.c:error:variable-csg_mod_mask-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- fs-smb-client-file.c:warning:variable-rc-is-used-uninitialized-whenever-if-condition-is-false
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- powerpc-eiger_defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- powerpc-mpc512x_defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- powerpc-randconfig-003-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- powerpc-randconfig-r054-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- powerpc64-randconfig-002-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- riscv-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-irq-dce110-irq_service_dce110.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_ddi.c:error:arithmetic-between-different-enumeration-types-(-enum-hpd_pin-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-pipe-and-enum-intel_display_power_domain-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-i915-display-intel_display.c:error:arithmetic-between-different-enumeration-types-(-enum-tc_port-and-enum-port-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-msm-adreno-a6xx_gpu_state.c:error:variable-out-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-panthor-panthor_sched.c:error:variable-csg_mod_mask-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- fs-smb-client-file.c:warning:variable-rc-is-used-uninitialized-whenever-if-condition-is-false
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- riscv-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-irq-dce110-irq_service_dce110.c:error:arithmetic-between-different-enumeration-types-(-enum-dc_irq_source-and-enum-irq_type-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-msm-adreno-a6xx_gpu_state.c:error:variable-out-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-panthor-panthor_sched.c:error:variable-csg_mod_mask-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- fs-smb-client-file.c:warning:variable-rc-is-used-uninitialized-whenever-if-condition-is-false
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- riscv-defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- riscv-randconfig-001-20240403
|   |-- fs-smb-client-file.c:warning:variable-rc-is-used-uninitialized-whenever-if-condition-is-false
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- riscv-randconfig-002-20240403
|   |-- fs-smb-client-file.c:warning:variable-rc-is-used-uninitialized-whenever-if-condition-is-false
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- s390-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-amd_asic_type-and-enum-amd_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ras.c:error:arithmetic-between-different-enumeration-types-(-enum-amdgpu_ras_block-and-enum-amdgpu_ras_mca_block-)-Werror-Wenum-enum-conversion
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-panthor-panthor_sched.c:error:variable-csg_mod_mask-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-radeon-radeon_drv.c:error:bitwise-operation-between-different-enumeration-types-(-enum-radeon_family-and-enum-radeon_chip_flags-)-Werror-Wenum-enum-conversion
|   |-- fs-smb-client-file.c:warning:variable-rc-is-used-uninitialized-whenever-if-condition-is-false
|   |-- include-asm-generic-io.h:error:performing-pointer-arithmetic-on-a-null-pointer-has-undefined-behavior-Werror-Wnull-pointer-arithmetic
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- s390-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- s390-defconfig
|   |-- fs-smb-client-file.c:warning:variable-rc-is-used-uninitialized-whenever-if-condition-is-false
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- s390-randconfig-001-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- s390-randconfig-002-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- um-allmodconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- um-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- um-defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- um-randconfig-002-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- um-x86_64_defconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-allmodconfig
|   |-- drivers-gpu-drm-kmb-kmb_dsi.c:error:unused-function-set_test_mode_src_osc_freq_target_hi_bits-Werror-Wunused-function
|   |-- drivers-gpu-drm-kmb-kmb_dsi.c:error:unused-function-set_test_mode_src_osc_freq_target_low_bits-Werror-Wunused-function
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-msm-adreno-a6xx_gpu_state.c:error:variable-out-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-panthor-panthor_sched.c:error:variable-csg_mod_mask-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-allnoconfig
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-allyesconfig
|   |-- drivers-gpu-drm-kmb-kmb_dsi.c:error:unused-function-set_test_mode_src_osc_freq_target_hi_bits-Werror-Wunused-function
|   |-- drivers-gpu-drm-kmb-kmb_dsi.c:error:unused-function-set_test_mode_src_osc_freq_target_low_bits-Werror-Wunused-function
|   |-- drivers-gpu-drm-lima-lima_drv.c:error:cast-to-smaller-integer-type-enum-lima_gpu_id-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- drivers-gpu-drm-msm-adreno-a6xx_gpu_state.c:error:variable-out-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-panthor-panthor_sched.c:error:variable-csg_mod_mask-set-but-not-used-Werror-Wunused-but-set-variable
|   |-- drivers-gpu-drm-pl111-pl111_versatile.c:error:cast-to-smaller-integer-type-enum-versatile_clcd-from-const-void-Werror-Wvoid-pointer-to-enum-cast
|   |-- fs-smb-client-file.c:warning:variable-rc-is-used-uninitialized-whenever-if-condition-is-false
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-buildonly-randconfig-003-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-buildonly-randconfig-005-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-002-20240403
|   |-- fs-smb-client-file.c:warning:variable-rc-is-used-uninitialized-whenever-if-condition-is-false
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-006-20240403
|   |-- fs-smb-client-file.c:warning:variable-rc-is-used-uninitialized-whenever-if-condition-is-false
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-071-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-073-20240403
|   |-- fs-smb-client-file.c:warning:variable-rc-is-used-uninitialized-whenever-if-condition-is-false
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-121-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
|-- x86_64-randconfig-123-20240403
|   |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
|   `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node
`-- x86_64-rhel-8.3-rust
    |-- fs-smb-client-file.c:warning:variable-rc-is-used-uninitialized-whenever-if-condition-is-false
    |-- mm-mempool.c:warning:Function-parameter-or-struct-member-gfp_mask-not-described-in-mempool_create_node
    `-- mm-mempool.c:warning:Function-parameter-or-struct-member-node_id-not-described-in-mempool_create_node

elapsed time: 726m

configs tested: 179
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240403   gcc  
arc                   randconfig-002-20240403   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                                 defconfig   clang
arm                       imx_v6_v7_defconfig   clang
arm                          pxa168_defconfig   clang
arm                   randconfig-001-20240403   gcc  
arm                   randconfig-002-20240403   gcc  
arm                   randconfig-003-20240403   clang
arm                   randconfig-004-20240403   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240403   clang
arm64                 randconfig-002-20240403   clang
arm64                 randconfig-003-20240403   gcc  
arm64                 randconfig-004-20240403   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240403   gcc  
csky                  randconfig-002-20240403   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240403   clang
hexagon               randconfig-002-20240403   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240403   gcc  
i386         buildonly-randconfig-002-20240403   clang
i386         buildonly-randconfig-003-20240403   clang
i386         buildonly-randconfig-004-20240403   clang
i386         buildonly-randconfig-005-20240403   gcc  
i386         buildonly-randconfig-006-20240403   clang
i386                                defconfig   clang
i386                  randconfig-001-20240403   gcc  
i386                  randconfig-002-20240403   clang
i386                  randconfig-003-20240403   gcc  
i386                  randconfig-004-20240403   gcc  
i386                  randconfig-005-20240403   clang
i386                  randconfig-006-20240403   gcc  
i386                  randconfig-011-20240403   gcc  
i386                  randconfig-012-20240403   clang
i386                  randconfig-013-20240403   gcc  
i386                  randconfig-014-20240403   clang
i386                  randconfig-015-20240403   gcc  
i386                  randconfig-016-20240403   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240403   gcc  
loongarch             randconfig-002-20240403   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm63xx_defconfig   clang
mips                      loongson3_defconfig   gcc  
mips                           mtx1_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240403   gcc  
nios2                 randconfig-002-20240403   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240403   gcc  
parisc                randconfig-002-20240403   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                       eiger_defconfig   clang
powerpc                     mpc512x_defconfig   clang
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc                    mvme5100_defconfig   gcc  
powerpc                      ppc64e_defconfig   gcc  
powerpc               randconfig-001-20240403   gcc  
powerpc               randconfig-002-20240403   gcc  
powerpc               randconfig-003-20240403   clang
powerpc                     stx_gp3_defconfig   clang
powerpc64             randconfig-001-20240403   gcc  
powerpc64             randconfig-002-20240403   clang
powerpc64             randconfig-003-20240403   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240403   clang
riscv                 randconfig-002-20240403   clang
s390                             alldefconfig   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240403   clang
s390                  randconfig-002-20240403   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240403   gcc  
sh                    randconfig-002-20240403   gcc  
sh                           se7721_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240403   gcc  
sparc64               randconfig-002-20240403   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240403   gcc  
um                    randconfig-002-20240403   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240403   gcc  
x86_64       buildonly-randconfig-002-20240403   gcc  
x86_64       buildonly-randconfig-003-20240403   clang
x86_64       buildonly-randconfig-004-20240403   gcc  
x86_64       buildonly-randconfig-005-20240403   clang
x86_64       buildonly-randconfig-006-20240403   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240403   gcc  
x86_64                randconfig-002-20240403   clang
x86_64                randconfig-003-20240403   gcc  
x86_64                randconfig-004-20240403   gcc  
x86_64                randconfig-005-20240403   gcc  
x86_64                randconfig-006-20240403   clang
x86_64                randconfig-011-20240403   gcc  
x86_64                randconfig-012-20240403   gcc  
x86_64                randconfig-013-20240403   gcc  
x86_64                randconfig-014-20240403   gcc  
x86_64                randconfig-015-20240403   gcc  
x86_64                randconfig-016-20240403   gcc  
x86_64                randconfig-071-20240403   clang
x86_64                randconfig-072-20240403   gcc  
x86_64                randconfig-073-20240403   clang
x86_64                randconfig-074-20240403   gcc  
x86_64                randconfig-075-20240403   gcc  
x86_64                randconfig-076-20240403   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240403   gcc  
xtensa                randconfig-002-20240403   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

