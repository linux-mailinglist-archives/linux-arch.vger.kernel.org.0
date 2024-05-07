Return-Path: <linux-arch+bounces-4233-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F42308BDD5C
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 10:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B044D284809
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 08:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3881014D2BA;
	Tue,  7 May 2024 08:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dx9ZEMBC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F40E13C9A2;
	Tue,  7 May 2024 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715071435; cv=none; b=EAb/8nF3EmCEN000w+tk8sBwTIx5hJAuduJ0Yt2XTbc0kBtf/S/Y//URiN9UCI+aHzdli55+1KJgxRC+1hNjXYjqlZnCNhizm0i+4WOV3adkfjnKgS644T7FwCh82ajAZrlHwtUxb3/sL6s5tam51cY3ASZLICg5rxQUN5jkz0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715071435; c=relaxed/simple;
	bh=jG+THjCeGW3zi8tCrAye5vr5GHkdWZme1tB+kqii8dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqoNGaiRH+itxXlW++QC4vlpT5sgpoyslOxTESMbqR/rN+6fbsGWYMJuAsmLxcj91OxLnTbV04vGHzvSLkX/N15QCX9XOaDg7FVoOF5Dk5p1qTVW0MhsQqHXMdIYnllb0w/yVzkD/BGoBFviT/Q2k5glcIKpxqmhZ2egs5PX22g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dx9ZEMBC; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59a64db066so702275666b.3;
        Tue, 07 May 2024 01:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715071432; x=1715676232; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5grxZOrhBPyt4V3AJI3sb+Y61ObnxWKs5SwjjhtWck=;
        b=Dx9ZEMBCf8QPc4iY/9P5wtN3Qb/4d5YFuKLOwhsbFSn9Ou27xeXaw9kkaKNvepWNRx
         AgW97QcXUghdqp+Q7RC7vhZnzVXDBHsMJWR+qnYmIo0RFKLNSqlmISmCVHajP2mzutB5
         Fwd5W4qmM6dGEG2tANy7PEqbQS+qdhP+oq0porxuy+tMhz6LHHV9EH5uy8YHr6muOrp5
         UpnsX5ZV6nboh/VAEXOmXBNU2qRAIy6W58Z21CpE/CKy30QOClJuqbR07VPyiH8r36JD
         OON7UCfRdo5wm8gyKjvX4cBrQyeEJx7E3M5E24JFvPZKHnbMIee5dgHi3gxA1T9Iaww2
         Qf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715071432; x=1715676232;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X5grxZOrhBPyt4V3AJI3sb+Y61ObnxWKs5SwjjhtWck=;
        b=kqYY8etL9gnDCETaRF8xLf5jttFvJQNxpH7pcbJIt0mkp/PM1vWeqVnSP5vSK4nOH3
         GknMwbr8YSC+zwjUl+fn27dS7P78krU2BFFhtaJxvGMzqe6EO9L+2fZBLvlOLZuAePXd
         jGsKsBq66x2yAGJ05THvgFjqg959NAXNNaei/vGuclbsRu3MV7Zypz5WuFqRuVCKUSAj
         GeVzwslYAxGhuIkuMNNkodwOtnmsuD13OBHm+pzShyD6Vkr84hxYUWP1PQdokqnAtiZc
         sHQhAldUW5Uyx8jimZJz8l9WfQE7u006EZE9IjxQDBOgjz8uUEsmqXPueVQpF2W3r2nJ
         T1Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVSBrUlrmGf6LFHJ/YqH32ZWUbFYJ5N4HIx5npzi9PfIbCVhspmPcabOzaOnIG+dAUaRVwGEXNPSLTmjehpqYJYjjsa9tfC8tmwljadE6U97BwBUcULzssAPGlhnX+Y8pLXh6FpgQxPxw==
X-Gm-Message-State: AOJu0YzCZVkjAEp5gsntNUzE8WBz5d+gn7Ft5fqumVOdXX+NKjF5Ml7m
	XOBm0FNMQ6fg9D/iQYUFzLpAs67Lt4zPi7VXjgd2j9lu9RR9adMQ
X-Google-Smtp-Source: AGHT+IGLgCI7he3kJp9TCd8g/C08i2amvg2QPJVDnTHoYk8pb2Bt8vfiWtniWWbfFNp2eQjqmWrExQ==
X-Received: by 2002:a50:aad1:0:b0:572:a76e:645a with SMTP id r17-20020a50aad1000000b00572a76e645amr7816340edc.12.1715071431748;
        Tue, 07 May 2024 01:43:51 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id d25-20020aa7ce19000000b00572a7127cb0sm6120455edv.50.2024.05.07.01.43.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2024 01:43:51 -0700 (PDT)
Date: Tue, 7 May 2024 08:43:50 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, arnd@arndb.de, rppt@kernel.org,
	oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/memblock: discard .text/.data if
 CONFIG_ARCH_KEEP_MEMBLOCK not set
Message-ID: <20240507084350.mc6e46gecyzaqnhb@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240506012104.10864-1-richard.weiyang@gmail.com>
 <202405071200.YgYuuCBu-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202405071200.YgYuuCBu-lkp@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, May 07, 2024 at 01:13:05PM +0800, kernel test robot wrote:
>Hi Wei,
>
>kernel test robot noticed the following build warnings:
>
>[auto build test WARNING on akpm-mm/mm-everything]
>
>url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Yang/mm-memblock-discard-text-data-if-CONFIG_ARCH_KEEP_MEMBLOCK-not-set/20240506-092345
>base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
>patch link:    https://lore.kernel.org/r/20240506012104.10864-1-richard.weiyang%40gmail.com
>patch subject: [PATCH] mm/memblock: discard .text/.data if CONFIG_ARCH_KEEP_MEMBLOCK not set
>config: powerpc-allnoconfig
>compiler: powerpc-linux-gcc (GCC) 13.2.0
>reproduce (this is a W=1 build):
>
>If you fix the issue in a separate patch/commit (i.e. not just a new version of
>the same patch/commit), kindly add following tags
>| Reported-by: kernel test robot <lkp@intel.com>
>| Closes: https://lore.kernel.org/oe-kbuild-all/202405071200.YgYuuCBu-lkp@intel.com/
>
>All warnings (new ones prefixed by >>):
>
>>> powerpc-linux-ld: warning: orphan section `.mbinit.text' from `mm/memblock.o' being placed in section `.mbinit.text'
>>> powerpc-linux-ld: warning: orphan section `.mbinit.text' from `mm/memblock.o' being placed in section `.mbinit.text'
>>> powerpc-linux-ld: warning: orphan section `.mbinit.text' from `mm/memblock.o' being placed in section `.mbinit.text'
>
>-- 
>0-DAY CI Kernel Test Service
>https://github.com/intel/lkp-tests/wiki

>reproduce (this is a W=1 build):
>        git clone https://github.com/intel/lkp-tests.git ~/lkp-tests
>        git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
>        git fetch akpm-mm mm-everything
>        git checkout akpm-mm/mm-everything
>        b4 shazam https://lore.kernel.org/r/20240506012104.10864-1-richard.weiyang@gmail.com
>        # save the config file
>        mkdir build_dir && cp config build_dir/.config
>        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-13.2.0 ~/lkp-tests/kbuild/make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
>        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-13.2.0 ~/lkp-tests/kbuild/make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

Can I reproduce this on x86? I don't have a powerpc machine.

-- 
Wei Yang
Help you, Help me

