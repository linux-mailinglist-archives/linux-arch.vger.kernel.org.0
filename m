Return-Path: <linux-arch+bounces-3479-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E14C89C693
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 16:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB83B1F22755
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 14:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E519785C73;
	Mon,  8 Apr 2024 14:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qPa3R7dl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xCMoMQYY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HgdG1WL7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ivj4rNJu"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E123185954;
	Mon,  8 Apr 2024 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585626; cv=none; b=rXNnKal+myp2LZfjex4GSTnzV9JnSK+HkTCV1BC7mw5DDM5VklGQWSUWGlNzwT8teAFQO9waf12ptrr6QIJu6W+vqmdyG4RCXk1Nb2iElZJc9tc+VxfT2wep7NGpO8P5Po091KVBaKe27dlUxhsSd3dmPV93yPxT8dO2dmf9lBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585626; c=relaxed/simple;
	bh=xKHs45sCXjWirNPURWSMSmBANrpE7BjdZS2nrjJheqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0SDnejtHacVNzW0Cb+9oYkiqkwdOy4pa1Dpji22yEZOxYIlwaAWpRQOWaIPD+6o0Y8yVvbTWk/3SYVhCDmc++Vphto5x9arbqtRoMgq00kxWtLBwrpT0nVoXCtrMQCHTPiss02jNnMUM5XbO/ddPDIfctIYEZjZfEo33TWsAfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qPa3R7dl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xCMoMQYY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HgdG1WL7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ivj4rNJu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D4C39203C0;
	Mon,  8 Apr 2024 14:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712585623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ayr9nY5u0guPXMZODishlG7fM8GQYWf//3cYslN7IQo=;
	b=qPa3R7dlFbgmkTr4opmQbPo187MAQfN4j0wthBxDlH4sxZ6oDCiiAh9R+qbvTlUdZ8f9dM
	VWKCJC6iGUXqvIWr4OmW1IMTtW41/sXZDdaPmsq9y60AERNgt/SvDYvpx2vjt79RV1v+xS
	Y1zgvRNsIhzytSoEqGWOdsQ6xLiTpNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712585623;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ayr9nY5u0guPXMZODishlG7fM8GQYWf//3cYslN7IQo=;
	b=xCMoMQYYYXsSnlYBJnpUw0LIndHEZ3ZH8SrzsR3t1Lzinv/5Ljqe6SO8oUWlcspejZ7XMP
	aYEc7PjppBUUtTAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712585622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ayr9nY5u0guPXMZODishlG7fM8GQYWf//3cYslN7IQo=;
	b=HgdG1WL7gBQJlOtqeSMNRvE9ztZRZOq751uzlKNdv2eakuPk9RmaZtmbSRj/C4y++/BrG3
	tE/KpZebnomLabDLTpP2SeACNggLHMvernQ8qzrQ3J9sYYW7r+iYEaR19NBRBM0SmVtB8l
	J/C/CzEonT7LAlfq2LO3TzLgksgRCR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712585622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ayr9nY5u0guPXMZODishlG7fM8GQYWf//3cYslN7IQo=;
	b=Ivj4rNJudTTGKITAXANi7hHItm+RqrN0eoFf/Tekq11k5m2BSlzDFYj9Z180TmFqS8i8vR
	Ihe5sZssCRNnGDDg==
Date: Mon, 8 Apr 2024 16:13:41 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Laurent Dufour <ldufour@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
	kernel test robot <lkp@intel.com>, dave.hansen@linux.intel.com,
	linux-kernel@vger.kernel.org, mingo@redhat.com, bp@alien8.de,
	npiggin@gmail.com, tglx@linutronix.de, rui.zhang@intel.com
Subject: Re: [PATCH v4 07/10] cpu/SMT: Allow enabling partial SMT states via
 sysfs
Message-ID: <20240408141341.GN20665@kitsune.suse.cz>
References: <20230705145143.40545-1-ldufour@linux.ibm.com>
 <20230705145143.40545-8-ldufour@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705145143.40545-8-ldufour@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_ZERO(0.00)[0];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,vger.kernel.org,intel.com,linux.intel.com,redhat.com,alien8.de,gmail.com,linutronix.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email]

Hello,

On Wed, Jul 05, 2023 at 04:51:40PM +0200, Laurent Dufour wrote:
> From: Michael Ellerman <mpe@ellerman.id.au>
> 
> Add support to the /sys/devices/system/cpu/smt/control interface for
> enabling a specified number of SMT threads per core, including partial
> SMT states where not all threads are brought online.
> 
> The current interface accepts "on" and "off", to enable either 1 or all
> SMT threads per core.
> 
> This commit allows writing an integer, between 1 and the number of SMT
> threads supported by the machine. Writing 1 is a synonym for "off", 2 or
> more enables SMT with the specified number of threads.
> 
> When reading the file, if all threads are online "on" is returned, to
> avoid changing behaviour for existing users. If some other number of
> threads is online then the integer value is returned.
> 
> Architectures like x86 only supporting 1 thread or all threads, should not
> define CONFIG_SMT_NUM_THREADS_DYNAMIC. Architecture supporting partial SMT
> states, like PowerPC, should define it.

This causes a regression:
https://groups.google.com/g/powerpc-utils-devel/c/wrwVzAAnRlI/m/5KJSoqP4BAAJ

The userspace code only changes the SMT mode of online CPUs (at lest one
thread is online) and does not touch offline CPUs.

Using this new interface offlined CPUs are onlined when SMT value is
set.

Would you look into special-casing the offline CPUs?

Thanks

Michal

> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> [ldufour: slightly reword the commit's description]
> [ldufour: remove switch() in __store_smt_control()]
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202306282340.Ihqm0fLA-lkp@intel.com/
> [ldufour: fix build issue in control_show()]
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> ---
>  .../ABI/testing/sysfs-devices-system-cpu      |  1 +
>  kernel/cpu.c                                  | 60 ++++++++++++++-----
>  2 files changed, 45 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index ecd585ca2d50..6dba65fb1956 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -555,6 +555,7 @@ Description:	Control Symmetric Multi Threading (SMT)
>  			 ================ =========================================
>  			 "on"		  SMT is enabled
>  			 "off"		  SMT is disabled
> +			 "<N>"		  SMT is enabled with N threads per core.
>  			 "forceoff"	  SMT is force disabled. Cannot be changed.
>  			 "notsupported"   SMT is not supported by the CPU
>  			 "notimplemented" SMT runtime toggling is not
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 9a8d0685e055..7e8f1b044772 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2876,11 +2876,19 @@ static const struct attribute_group cpuhp_cpu_root_attr_group = {
>  
>  #ifdef CONFIG_HOTPLUG_SMT
>  
> +static bool cpu_smt_num_threads_valid(unsigned int threads)
> +{
> +	if (IS_ENABLED(CONFIG_SMT_NUM_THREADS_DYNAMIC))
> +		return threads >= 1 && threads <= cpu_smt_max_threads;
> +	return threads == 1 || threads == cpu_smt_max_threads;
> +}
> +
>  static ssize_t
>  __store_smt_control(struct device *dev, struct device_attribute *attr,
>  		    const char *buf, size_t count)
>  {
> -	int ctrlval, ret;
> +	int ctrlval, ret, num_threads, orig_threads;
> +	bool force_off;
>  
>  	if (cpu_smt_control == CPU_SMT_FORCE_DISABLED)
>  		return -EPERM;
> @@ -2888,30 +2896,39 @@ __store_smt_control(struct device *dev, struct device_attribute *attr,
>  	if (cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
>  		return -ENODEV;
>  
> -	if (sysfs_streq(buf, "on"))
> +	if (sysfs_streq(buf, "on")) {
>  		ctrlval = CPU_SMT_ENABLED;
> -	else if (sysfs_streq(buf, "off"))
> +		num_threads = cpu_smt_max_threads;
> +	} else if (sysfs_streq(buf, "off")) {
>  		ctrlval = CPU_SMT_DISABLED;
> -	else if (sysfs_streq(buf, "forceoff"))
> +		num_threads = 1;
> +	} else if (sysfs_streq(buf, "forceoff")) {
>  		ctrlval = CPU_SMT_FORCE_DISABLED;
> -	else
> +		num_threads = 1;
> +	} else if (kstrtoint(buf, 10, &num_threads) == 0) {
> +		if (num_threads == 1)
> +			ctrlval = CPU_SMT_DISABLED;
> +		else if (cpu_smt_num_threads_valid(num_threads))
> +			ctrlval = CPU_SMT_ENABLED;
> +		else
> +			return -EINVAL;
> +	} else {
>  		return -EINVAL;
> +	}
>  
>  	ret = lock_device_hotplug_sysfs();
>  	if (ret)
>  		return ret;
>  
> -	if (ctrlval != cpu_smt_control) {
> -		switch (ctrlval) {
> -		case CPU_SMT_ENABLED:
> -			ret = cpuhp_smt_enable();
> -			break;
> -		case CPU_SMT_DISABLED:
> -		case CPU_SMT_FORCE_DISABLED:
> -			ret = cpuhp_smt_disable(ctrlval);
> -			break;
> -		}
> -	}
> +	orig_threads = cpu_smt_num_threads;
> +	cpu_smt_num_threads = num_threads;
> +
> +	force_off = ctrlval != cpu_smt_control && ctrlval == CPU_SMT_FORCE_DISABLED;
> +
> +	if (num_threads > orig_threads)
> +		ret = cpuhp_smt_enable();
> +	else if (num_threads < orig_threads || force_off)
> +		ret = cpuhp_smt_disable(ctrlval);
>  
>  	unlock_device_hotplug();
>  	return ret ? ret : count;
> @@ -2939,6 +2956,17 @@ static ssize_t control_show(struct device *dev,
>  {
>  	const char *state = smt_states[cpu_smt_control];
>  
> +#ifdef CONFIG_HOTPLUG_SMT
> +	/*
> +	 * If SMT is enabled but not all threads are enabled then show the
> +	 * number of threads. If all threads are enabled show "on". Otherwise
> +	 * show the state name.
> +	 */
> +	if (cpu_smt_control == CPU_SMT_ENABLED &&
> +	    cpu_smt_num_threads != cpu_smt_max_threads)
> +		return sysfs_emit(buf, "%d\n", cpu_smt_num_threads);
> +#endif
> +
>  	return snprintf(buf, PAGE_SIZE - 2, "%s\n", state);
>  }
>  
> -- 
> 2.41.0
> 

