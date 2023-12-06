Return-Path: <linux-arch+bounces-725-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78820807A22
	for <lists+linux-arch@lfdr.de>; Wed,  6 Dec 2023 22:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 228791F2198B
	for <lists+linux-arch@lfdr.de>; Wed,  6 Dec 2023 21:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A1E6ABBD;
	Wed,  6 Dec 2023 21:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XG1UMych"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3F7D69
	for <linux-arch@vger.kernel.org>; Wed,  6 Dec 2023 13:09:03 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1d048d38881so1590045ad.2
        for <linux-arch@vger.kernel.org>; Wed, 06 Dec 2023 13:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701896943; x=1702501743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r0jZIh33WJZDOGC0jgw5Fc4RYCqpyNHwEvNXaQB/Zzg=;
        b=XG1UMychDGvLI1nGeQMU7BYFeIanHRqEH9y4oH8/imC6Cqc2MFi9PryXlhFGgWYOaW
         suBK0gYzw4jzb8IHEieNdqvqZKLH3+X4dNQ5KJdi3wOh40PA1gaOUt4cy6P/6w5c1GQU
         wWyTaUxjwVZIT9ZrxRV/NiYy16u4AF7yi1xVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701896943; x=1702501743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0jZIh33WJZDOGC0jgw5Fc4RYCqpyNHwEvNXaQB/Zzg=;
        b=TYUnO98Jkuhwyj0Whge7FTaAUu2vCLchSP1jXhtLryfqo61sIH5G00Z590qp+a2Z1E
         EMH+NTqbjlQQYjjEZoOdhaG85g6a54BI+0hJKZTyYnkprqDizYDqtquZbi3WNmsxL/Ma
         6B1VxQCeobRdIwnkCyG/DS2y8au+1xQB+IVPxcgFw6PHlLLwgzqLzhqyENe7B9ZYzkuc
         H+FGFaG7IfdDUimpKkw1lAwnvox9MuLu4gsQ0buCNzdoqJkGrBLCI1JQNHP1TleWRTV1
         Hv+udCCm+fUV7kxLWO16m6BeEA+8XU5kXrFVUuPj56SmXeadFZh5vDc0IIncbgSPnqzO
         q2xg==
X-Gm-Message-State: AOJu0YwvnRiA6zkR0d2QchbHB8T4XxVguNsx2/EKz2rAGt5t37CwaD4p
	YythrzlO03Hi9vzQqxpRatL7DQ==
X-Google-Smtp-Source: AGHT+IFQfQna/1EdVH0X+3X9HH+a9W9KXtDeaY2iTQz/5U8JSAc0AgMNRHkYjwLaZszqnToXGMyAxQ==
X-Received: by 2002:a17:903:22cd:b0:1d0:7165:3faf with SMTP id y13-20020a17090322cd00b001d071653fafmr1374702plg.63.1701896942889;
        Wed, 06 Dec 2023 13:09:02 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jm21-20020a17090304d500b001d06b93c66dsm244368plb.233.2023.12.06.13.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 13:09:02 -0800 (PST)
Date: Wed, 6 Dec 2023 13:09:01 -0800
From: Kees Cook <keescook@chromium.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2] ELF: supply userspace with available page shifts
 (AT_PAGE_SHIFT_MASK)
Message-ID: <202312061308.630C56CCA@keescook>
References: <6b399b86-a478-48b0-92a1-25240a8ede54@p183>
 <87v89dvuxg.fsf@oldenburg.str.redhat.com>
 <1d679805-8a82-44a4-ba14-49d4f28ff597@p183>
 <202312061236.DE847C52AA@keescook>
 <87edfzavof.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edfzavof.fsf@oldenburg.str.redhat.com>

On Wed, Dec 06, 2023 at 10:05:36PM +0100, Florian Weimer wrote:
> * Kees Cook:
> 
> > On Tue, Dec 05, 2023 at 07:01:34PM +0300, Alexey Dobriyan wrote:
> >> Report available page shifts in arch independent manner, so that
> >> userspace developers won't have to parse /proc/cpuinfo hunting
> >> for arch specific strings:
> >> 
> >> Note!
> >> 
> >> This is strictly for userspace, if some page size is shutdown due
> >> to kernel command line option or CPU bug workaround, than is must not
> >> be reported in aux vector!
> >
> > Given Florian in CC, I assume this is something glibc would like to be
> > using? Please mention this in the commit log.
> 
> Nope, I just wrote a random drive-by comment on the first version.

Ah, okay. Then Alexey, who do you expect to be the consumer of this new
AT value?

-- 
Kees Cook

