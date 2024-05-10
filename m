Return-Path: <linux-arch+bounces-4294-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AC28C1C3D
	for <lists+linux-arch@lfdr.de>; Fri, 10 May 2024 03:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE3961C21266
	for <lists+linux-arch@lfdr.de>; Fri, 10 May 2024 01:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEDC13B792;
	Fri, 10 May 2024 01:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihL8ctWD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B2513B787;
	Fri, 10 May 2024 01:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715306076; cv=none; b=PsnqMoEhqgSBTwck71YQDiHZTugxsgWfyWHftb0M7eXxPy1WOTkGeZj2Nr6mlZQbE4HdJuahgHzQLEUYk7tJPhBMqBtY0OO/91o6XItnMMvF0Sb0QH1toRYcbapYzKt5wMAjGIaPC6PDqQxvwhuVQ+kOf6F1K6dTp2AoD51tp0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715306076; c=relaxed/simple;
	bh=mMkYUl68yZLTzGlW7UIXIbIlr64TygSr5Pw7nD57FbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d46SaiBFZdaP7YhqpF2INwg22EGofTempQ1BvszI7aMCdG1ZY+5TdOzNRVchrPMZHMEsOnDtFEERQ/UXxuaBljEDuf25T9XtECKfD3aw8rly5GEBKQ5VrTt38Uqi9leGckPp5+A5PZC2CVJqe/HUo+X3eg3NNUoB5LI74LNGh0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihL8ctWD; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a59ab4f60a6so340460966b.0;
        Thu, 09 May 2024 18:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715306072; x=1715910872; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXTf1Spaxf38XUied9hUFPIkMdQ4wUBR6hmvOHQ103w=;
        b=ihL8ctWDB15NzJkl74p0l4M2wLhTxQerKDJaxE4Q4y1BC06nGZ3WNqd83wBL0djq/2
         K0jp0Qwt/7b+3L21oxgAPjQw7g6jvh+GFqmtTrHF7AdeN024XMSy9zpI+Qp6+65xaKW/
         2S2eV9S8RkSiwtkNCn2qIHk8gxNlhYfnUySw88wfdEdCRvxmudwylCHD48I+hf1jvG+O
         ryPnUZN2yFwlMpIqNjpDGlQXHi96Zt0DOErO59pg9zGNhU+MDieVoP5kb7t04VY57LvJ
         vvD8dXpQQ5lzFRf8fMKW8X/evcOiF4ELT3IimjGnEeKH00xj9uW/HBt+9VZpbDfeMTLN
         kVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715306072; x=1715910872;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aXTf1Spaxf38XUied9hUFPIkMdQ4wUBR6hmvOHQ103w=;
        b=VYAlZX0MAUQPyHuuCEHfhPNBQPTxAhwqH/uVPElo8ASQBJ3Iaa5LoRr922lvC+Ix3J
         JlQPAeCJqCEywTlZF1r6QVI0bRnwHINzEHHVVsYt8x/jEk3rV1B5/1USLM3Op8Qs/rnP
         vZ0APmq8jaZuKAhERRuHcchUy2Rz+EyaCv8kmRPqA4K4WklYBhSnKtut+hKKLozNwUAO
         fOv82F8PvNa/RBiO6R0R06/ie8I2Wtlmp0Lpb6AADTpgo1o2bwgLNqB1+8ooe5ihotvJ
         wIFDK9bb6hGIQJhZO7xD61GXeeX6wxIYPbCsmoatJGUm5LerIjYjHtZVumcrLOrGrqBd
         x5GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUq1NElITGZgSCZ4gqY6b8459WrOX2yWinVy+dThF9/ggDZ6tNAtpeeurh7AtZlOuk7XiDyCitjcodwT+gz4tJieDD03n53orYpBCQ/k+nAihFhIhYalDlrXO3cjqX0wPoTuFMiZZFHWA==
X-Gm-Message-State: AOJu0Yz1OKWTGvkru17Mcbg3nIFIO0oudsF57DQVFpwHTX6erCPar7fI
	RoRijqcjaemoR2CVLOZZEAh1VoGIF4b+3f7GSs3QB3HHi5eqi8we
X-Google-Smtp-Source: AGHT+IFxjdKrr+AKIROCEwpZ+jZhaAJNBjXLnX+atHD9nS7kVMvzgP93kC4YAp2RFOhq++HSXzsgAA==
X-Received: by 2002:a17:907:36cd:b0:a5a:1a:b0e6 with SMTP id a640c23a62f3a-a5a2d53b98dmr135177966b.9.1715306072358;
        Thu, 09 May 2024 18:54:32 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7f27sm132954566b.127.2024.05.09.18.54.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2024 18:54:31 -0700 (PDT)
Date: Fri, 10 May 2024 01:54:30 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Yujie Liu <yujie.liu@intel.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, kernel test robot <lkp@intel.com>,
	arnd@arndb.de, rppt@kernel.org, oe-kbuild-all@lists.linux.dev,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/memblock: discard .text/.data if
 CONFIG_ARCH_KEEP_MEMBLOCK not set
Message-ID: <20240510015203.bige6ddog5o22zvr@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240506012104.10864-1-richard.weiyang@gmail.com>
 <202405071200.YgYuuCBu-lkp@intel.com>
 <20240507084350.mc6e46gecyzaqnhb@master>
 <ZjrsRSryTFOZpT8o@yujie-X299>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjrsRSryTFOZpT8o@yujie-X299>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, May 08, 2024 at 11:06:45AM +0800, Yujie Liu wrote:
>On Tue, May 07, 2024 at 08:43:50AM +0000, Wei Yang wrote:
>> On Tue, May 07, 2024 at 01:13:05PM +0800, kernel test robot wrote:
>> >Hi Wei,
>> >
>> >kernel test robot noticed the following build warnings:
>> >
>> >[auto build test WARNING on akpm-mm/mm-everything]
>> >
>> >url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Yang/mm-memblock-discard-text-data-if-CONFIG_ARCH_KEEP_MEMBLOCK-not-set/20240506-092345
>> >base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
>> >patch link:    https://lore.kernel.org/r/20240506012104.10864-1-richard.weiyang%40gmail.com
>> >patch subject: [PATCH] mm/memblock: discard .text/.data if CONFIG_ARCH_KEEP_MEMBLOCK not set
>> >config: powerpc-allnoconfig
>> >compiler: powerpc-linux-gcc (GCC) 13.2.0
>> >reproduce (this is a W=1 build):
>> >
>> >If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> >the same patch/commit), kindly add following tags
>> >| Reported-by: kernel test robot <lkp@intel.com>
>> >| Closes: https://lore.kernel.org/oe-kbuild-all/202405071200.YgYuuCBu-lkp@intel.com/
>> >
>> >All warnings (new ones prefixed by >>):
>> >
>> >>> powerpc-linux-ld: warning: orphan section `.mbinit.text' from `mm/memblock.o' being placed in section `.mbinit.text'
>> >>> powerpc-linux-ld: warning: orphan section `.mbinit.text' from `mm/memblock.o' being placed in section `.mbinit.text'
>> >>> powerpc-linux-ld: warning: orphan section `.mbinit.text' from `mm/memblock.o' being placed in section `.mbinit.text'
>> >
>> >-- 
>> >0-DAY CI Kernel Test Service
>> >https://github.com/intel/lkp-tests/wiki
>> 
>> >reproduce (this is a W=1 build):
>> >        git clone https://github.com/intel/lkp-tests.git ~/lkp-tests
>> >        git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
>> >        git fetch akpm-mm mm-everything
>> >        git checkout akpm-mm/mm-everything
>> >        b4 shazam https://lore.kernel.org/r/20240506012104.10864-1-richard.weiyang@gmail.com
>> >        # save the config file
>> >        mkdir build_dir && cp config build_dir/.config
>> >        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-13.2.0 ~/lkp-tests/kbuild/make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
>> >        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-13.2.0 ~/lkp-tests/kbuild/make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash
>> 
>> Can I reproduce this on x86? I don't have a powerpc machine.
>
>The above steps are cross compiling for powerpc target on x86
>machine, so you can just follow the steps to reproduce on x86.
>

Thanks, this one is helpful.

>Thanks,
>Yujie

-- 
Wei Yang
Help you, Help me

