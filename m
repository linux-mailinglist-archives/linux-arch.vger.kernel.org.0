Return-Path: <linux-arch+bounces-15049-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C048C7C70D
	for <lists+linux-arch@lfdr.de>; Sat, 22 Nov 2025 05:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ACF83A732E
	for <lists+linux-arch@lfdr.de>; Sat, 22 Nov 2025 04:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1B72868BD;
	Sat, 22 Nov 2025 04:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TIfsmA3Y"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509C314B08A;
	Sat, 22 Nov 2025 04:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763787394; cv=none; b=jSisR09eok3zkyjfGBJGLhLz/JJBqTbIUZJ9vBgiCUHJ9htYiD2UWjMARJY4OKhFNanDfPUTu2z6w6IbRFml2KKBzyfQ8eP5HWpuhA8EpHPDXgidBFb8nmuOHktPAp0yyRpJpkAdjTGb6UETVyQYQDddBsozRCMdXLk3kUkGtlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763787394; c=relaxed/simple;
	bh=RpAta5pW7pTRynNxwbJLZvj/eo8rVxs+scWqmeP4VCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hO7MQTwC4du9XR2ZlFuRpHXtLIDjmuYZG7eSoJ/meelHLzq3gDVlxbT61w1lVgNCCYijgGtZiHO8/I8px1oR+UwoPKz9IMkyi2d8uM6JJk6AaPGyupYjM7JJe89tTZOjJKL8tH9OYTLXaYZGlgkJzGRVnlAtrLtEFDabFJ9hVX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TIfsmA3Y; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763787392; x=1795323392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RpAta5pW7pTRynNxwbJLZvj/eo8rVxs+scWqmeP4VCc=;
  b=TIfsmA3YELRqdFOG5kxNyY0mJGGhIihCuuoMxgnKm/x/KxOATUDDlKDZ
   YGDS9E0/TQiqBjH97czx8oouMdfk4wW4R2LNCnOtv7HKx8MFHAE26QcZs
   THQRWW0YuRLu5jwpiG6yzmnlWJVWWJcNKYQm9LVBnPArV8x0wMoCA+3yf
   boCx5zf483+05Oa4FSOBAaFxPzgBlvQfBFjx5II0lPL6CxMas+fSkRGHV
   EhS+xwdxvnLcAxLugtJEimVfUd6mJswhibtzT+p29Ft7JIeqUKbRDiRjf
   9aH9KtzIPjbj/8Izemi7kU4Ko4VHZnET1njnShpjmQnSw1ZrNf8IhFIo8
   Q==;
X-CSE-ConnectionGUID: rWB4kyrkSV+oh35eT8kL1w==
X-CSE-MsgGUID: bXU6oBRESLq77OoCC8z9bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11620"; a="65068435"
X-IronPort-AV: E=Sophos;i="6.20,217,1758610800"; 
   d="scan'208";a="65068435"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 20:56:31 -0800
X-CSE-ConnectionGUID: TyUuip1jSRSAWl7cfJynJA==
X-CSE-MsgGUID: rNBLW3izQzutdtYWUy0/fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,217,1758610800"; 
   d="scan'208";a="222811795"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 21 Nov 2025 20:56:26 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vMffc-0007AZ-1E;
	Sat, 22 Nov 2025 04:56:24 +0000
Date: Sat, 22 Nov 2025 12:55:58 +0800
From: kernel test robot <lkp@intel.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	tglx@linutronix.de, andersson@kernel.org, pmladek@suse.com,
	rdunlap@infradead.org, corbet@lwn.net, david@redhat.com,
	mhocko@suse.com
Cc: oe-kbuild-all@lists.linux.dev, tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com, linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org, jonechou@google.com,
	rostedt@goodmis.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-arch@vger.kernel.org, tony.luck@intel.com, kees@kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: Re: [PATCH 23/26] soc: qcom: Add minidump driver
Message-ID: <202511221252.PPEXScZ2-lkp@intel.com>
References: <20251119154427.1033475-24-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119154427.1033475-24-eugen.hristev@linaro.org>

Hi Eugen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rppt-memblock/fixes]
[also build test WARNING on linus/master v6.18-rc6]
[cannot apply to akpm-mm/mm-everything rppt-memblock/for-next next-20251121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eugen-Hristev/kernel-Introduce-meminspect/20251119-235912
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git fixes
patch link:    https://lore.kernel.org/r/20251119154427.1033475-24-eugen.hristev%40linaro.org
patch subject: [PATCH 23/26] soc: qcom: Add minidump driver
config: nios2-randconfig-r123-20251122 (https://download.01.org/0day-ci/archive/20251122/202511221252.PPEXScZ2-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251122/202511221252.PPEXScZ2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511221252.PPEXScZ2-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/soc/qcom/minidump.c:108:35: sparse: sparse: restricted __le32 degrades to integer
>> drivers/soc/qcom/minidump.c:154:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] seq_num @@     got unsigned int enum meminspect_uid const id @@
   drivers/soc/qcom/minidump.c:154:22: sparse:     expected restricted __le32 [usertype] seq_num
   drivers/soc/qcom/minidump.c:154:22: sparse:     got unsigned int enum meminspect_uid const id
>> drivers/soc/qcom/minidump.c:184:19: sparse: sparse: unsigned value that used to be signed checked against zero?
   drivers/soc/qcom/minidump.c:183:39: sparse: signed value source

vim +108 drivers/soc/qcom/minidump.c

    93	
    94	/**
    95	 * qcom_md_get_region_index() - Lookup minidump region by id
    96	 * @md: minidump data
    97	 * @id: minidump region id
    98	 *
    99	 * Return: On success, it returns the internal region index, on failure,
   100	 *	returns	negative error value
   101	 */
   102	static int qcom_md_get_region_index(struct minidump *md, int id)
   103	{
   104		unsigned int count = le32_to_cpu(md->toc->region_count);
   105		unsigned int i;
   106	
   107		for (i = 0; i < count; i++)
 > 108			if (md->regions[i].seq_num == id)
   109				return i;
   110	
   111		return -ENOENT;
   112	}
   113	
   114	/**
   115	 * register_md_region() - Register a new minidump region
   116	 * @priv: private data
   117	 * @e: pointer to inspect entry
   118	 *
   119	 * Return: None
   120	 */
   121	static void __maybe_unused register_md_region(void *priv,
   122						      const struct inspect_entry *e)
   123	{
   124		unsigned int num_region, region_cnt;
   125		const char *name = "unknown";
   126		struct minidump_region *mdr;
   127		struct minidump *md = priv;
   128	
   129		if (!(e->va || e->pa) || !e->size) {
   130			dev_dbg(md->dev, "invalid region requested\n");
   131			return;
   132		}
   133	
   134		if (e->id < ARRAY_SIZE(meminspect_id_to_md_string))
   135			name = meminspect_id_to_md_string[e->id];
   136	
   137		if (qcom_md_get_region_index(md, e->id) >= 0) {
   138			dev_dbg(md->dev, "%s:%d region is already registered\n",
   139				name, e->id);
   140			return;
   141		}
   142	
   143		/* Check if there is a room for a new entry */
   144		num_region = le32_to_cpu(md->toc->region_count);
   145		if (num_region >= MAX_NUM_REGIONS) {
   146			dev_dbg(md->dev, "maximum region limit %u reached\n",
   147				num_region);
   148			return;
   149		}
   150	
   151		region_cnt = le32_to_cpu(md->toc->region_count);
   152		mdr = &md->regions[region_cnt];
   153		scnprintf(mdr->name, MAX_REGION_NAME_LENGTH, "K%.8s", name);
 > 154		mdr->seq_num = e->id;
   155		if (e->pa)
   156			mdr->address = cpu_to_le64(e->pa);
   157		else if (e->va)
   158			mdr->address = cpu_to_le64(__pa(e->va));
   159		mdr->size = cpu_to_le64(ALIGN(e->size, 4));
   160		mdr->valid = cpu_to_le32(MINIDUMP_REGION_VALID);
   161		region_cnt++;
   162		md->toc->region_count = cpu_to_le32(region_cnt);
   163	
   164		dev_dbg(md->dev, "%s:%d region registered %llx:%llx\n",
   165			mdr->name, mdr->seq_num, mdr->address, mdr->size);
   166	}
   167	
   168	/**
   169	 * unregister_md_region() - Unregister a previously registered minidump region
   170	 * @priv: private data
   171	 * @e: pointer to inspect entry
   172	 *
   173	 * Return: None
   174	 */
   175	static void __maybe_unused unregister_md_region(void *priv,
   176							const struct inspect_entry *e)
   177	{
   178		struct minidump_region *mdr;
   179		struct minidump *md = priv;
   180		unsigned int region_cnt;
   181		unsigned int idx;
   182	
   183		idx = qcom_md_get_region_index(md, e->id);
 > 184		if (idx < 0) {
   185			dev_dbg(md->dev, "%d region is not present\n", e->id);
   186			return;
   187		}
   188	
   189		mdr = &md->regions[0];
   190		region_cnt = le32_to_cpu(md->toc->region_count);
   191	
   192		/*
   193		 * Left shift one position all the regions located after the
   194		 * region being removed, in order to fill the gap.
   195		 * Then, zero out the last region at the end.
   196		 */
   197		memmove(&mdr[idx], &mdr[idx + 1], (region_cnt - idx - 1) * sizeof(*mdr));
   198		memset(&mdr[region_cnt - 1], 0, sizeof(*mdr));
   199		region_cnt--;
   200		md->toc->region_count = cpu_to_le32(region_cnt);
   201	}
   202	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

