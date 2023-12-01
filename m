Return-Path: <linux-arch+bounces-597-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AF0800C9D
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 14:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A15EB21326
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 13:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2813BB5D;
	Fri,  1 Dec 2023 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Yk573CjB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE73197
	for <linux-arch@vger.kernel.org>; Fri,  1 Dec 2023 05:53:35 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c9d2ca9a96so19914761fa.3
        for <linux-arch@vger.kernel.org>; Fri, 01 Dec 2023 05:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701438814; x=1702043614; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B2gDIyfWC+W4ytDLyZ1ApFFOSpObEoeppni2yotM7Sk=;
        b=Yk573CjBNOA4iH35REuCAlz0xcvrPdhovdZ10G+9ct9/82MJ2VUkatWF5ob7pNDWHA
         quWrakx+4FF5/3XxvR9LtyfIDhm487E0vDDSXGnyFHtYI6mDH0TY6fk/h/3gmV1C23gR
         u+j36SCyGcOQ6ubn8/4hNrahVAFCc3S6xZJ7yYv2HkoAaRGWKI7xwDI1Farhm0gLIuG8
         w0y0Ix375m7LdTFa20D2Cd7XERlNahb3EAJ9mSeSu3MSKb5MmvJJmbEikY+vNDgLL2E4
         BwlqV0QaZcYNaGlMM5nWO8nalNRO1MUptzEi0wUC7rWJ8FgsQNWGbd3WwOgSVDDkcvIi
         cj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701438814; x=1702043614;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2gDIyfWC+W4ytDLyZ1ApFFOSpObEoeppni2yotM7Sk=;
        b=LkWQOo/bhnu5Uiq9UcRccviL1NEhxUmYhp+blch678OmMapE0bL120g42wiYVhcmhI
         nkJXIzrBCGaFP+k3H6V/oi/ESM7yFkXBSWBdLkCDbJ4C+iIy6UnMzkcSUyGuMW3L5ZWa
         R3j6m2O8YdoWggBDI4WKP/qaRkmt9W/NeNdd4RaP/geo6uKtSxFHbrMul/hA4tm5yr27
         s6DrCWIy/zNfVf3/z/GN6WiA0yWJb4PmrKuW23HUTTDfDXOVe+eO4Wk7++v1DjTr2UkC
         oMUlQslBXIl1979W4KcEGQqbd+ZbhfIvx7GE6AT4Qb/KdXEZVpVMALBQllqSDGYfiM7f
         62VQ==
X-Gm-Message-State: AOJu0YxNcCLrdeA778CGaO+aF42/G2OhklLCtFfMtoilPi36orqHBplI
	mBkVHmw2/WJaLXO14rmnhJG/yJsC1X0TcGAvSqc94A==
X-Google-Smtp-Source: AGHT+IEWbDp/BHTI35lHYKJahi0bZ7EApCyKw47RGLaZzY7863jjC5lW9Ntg2R4fr5oj1AbZZjB53QPWww4cZ5h4s3o=
X-Received: by 2002:a2e:8783:0:b0:2c9:c22e:31eb with SMTP id
 n3-20020a2e8783000000b002c9c22e31ebmr611668lji.22.1701438814214; Fri, 01 Dec
 2023 05:53:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZV5zGROLefrsEcHJ@r13-u19.micron.com> <CACSyD1OFjROw26+2ojG37eDBParVg721x1HCROMiF2pW2aHj8A@mail.gmail.com>
 <ZV/HSFMmv3xwkNPL@memverge.com> <CACSyD1MrCzyV-93Ov07NpV3Nm3u0fYExmD1ShE_e2tapW6a6HA@mail.gmail.com>
 <ZWizUEd/rsxSc0fW@memverge.com>
In-Reply-To: <ZWizUEd/rsxSc0fW@memverge.com>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Fri, 1 Dec 2023 21:53:23 +0800
Message-ID: <CACSyD1PCjPEwPCVXKVULjbNwxUG89DZUUfiDLg+wFyJRJXAPzA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/mbind: Introduce process_mbind() syscall for
 external memory binding
To: Gregory Price <gregory.price@memverge.com>
Cc: Vinicius Petrucci <vpetrucci@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-api@vger.kernel.org, minchan@kernel.org, dave.hansen@linux.intel.com, 
	x86@kernel.org, Jonathan.Cameron@huawei.com, aneesh.kumar@linux.ibm.com, 
	ying.huang@intel.com, dan.j.williams@intel.com, fvdl@google.com, 
	surenb@google.com, rientjes@google.com, hannes@cmpxchg.org, mhocko@suse.com, 
	Hasan.Maruf@amd.com, jgroves@micron.com, ravis.opensrc@micron.com, 
	sthanneeru@micron.com, emirakhur@micron.com, vtavarespetr@micron.com
Content-Type: text/plain; charset="UTF-8"

>
> Hi ZhongKun!
>
> I actually just sent out a more general RFC to mempolicy updates that
> discuss this more completely:
>
> https://lore.kernel.org/linux-mm/ZWezcQk+BYEq%2FWiI@memverge.com/
>

OK.

> and another post on even more issues with pidfd modifications to vma
> mempolicies:
>
> https://lore.kernel.org/linux-mm/ZWYsth2CtC4Ilvoz@memverge.com/
>
> We may have to slow-walk the changes to vma policies due to there being
> many more hidden accesses to (current) than expected. It's a rather
> nasty rats nest of mempolicy-vma-cpusets-shmem callbacks that obscure
> these current-task accesses, it will take time to work through.
>

Got it, thanks. It's more complicated than I thought.

> As for hot-path reference counting - we may need to change the way
> mempolicy is managed, possibly we could leverage RCU to manage mempolicy
> references in the hot path, rather than using locks.  In this scenario,
> we would likely need to change the way the default policy is applied
> (maybe not, I haven't fully explored it).
>

RCU may have a long time in the read-side critical section.

We should probably replace the atomic_t refcnt with percpu_ref in
mempolicy(also suggested by Michal), but refactoring work involves
a lot of code.

A simple way is to use task_work to release the mempolicy which may
be used by alloc_pages(). But it doesn't have a direct result.

> Do you have thoughts on this?  Would very much like additional comments
> before I go through the refactor work.
>
> Regards,
> Gregory

