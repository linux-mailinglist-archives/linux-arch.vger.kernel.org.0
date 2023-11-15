Return-Path: <linux-arch+bounces-230-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 919857ED735
	for <lists+linux-arch@lfdr.de>; Wed, 15 Nov 2023 23:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41CED2810E1
	for <lists+linux-arch@lfdr.de>; Wed, 15 Nov 2023 22:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1FD446C6;
	Wed, 15 Nov 2023 22:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UY5yWcNx"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7B91AC
	for <linux-arch@vger.kernel.org>; Wed, 15 Nov 2023 14:30:12 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc9b626a96so1686385ad.2
        for <linux-arch@vger.kernel.org>; Wed, 15 Nov 2023 14:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700087412; x=1700692212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YylxupOkQhFH1ncpqsZvMSikxbKYHt85VPH5cA+G+Oo=;
        b=UY5yWcNxei8PxZpZqzxd+lFoYgrgy/jNJZMxjVlaSeEZWSfPdnxu+FrfvYURvlHUlB
         DLWLWwnusiS2lBerr6nPgpZW4oNTflwThvOQn1U/VqkOnIQc3cEHNkWamvSqgMjj2WSZ
         XBnEMmp189E4O9bUV6L0BgChoewcfzpqP/AjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700087412; x=1700692212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YylxupOkQhFH1ncpqsZvMSikxbKYHt85VPH5cA+G+Oo=;
        b=T1IChidioQ0Jmi68RD967MBzme3uUztPs+iLg1ClobkTSmgteb+NkCFWJlXRyv+03M
         uuN1AZUWd5zPzBmhHi/qXkMZ+my5cC+ULipT920BsJeJJS7ilfom9HqoFT5okDe64G95
         W9gvERt7OljW9zvLAfvWkjPPfYjDKFimgn7ue7g278MqcaEBlD/YwubNR3kzjgwIXr+x
         kt6LFrXoIz4tNA7919IEgy2kmNKXHI6IrxTFDK5BAEQcRZSN7ai0qfB6MS0xk3Miq9im
         c4hqfRrVh8UZloZMBBv1ajc+eSAN+IoFdfHCVYrfPUrj39BK+whntEVSycsvnCbxftJn
         2ARQ==
X-Gm-Message-State: AOJu0YzEDo4A6YAJkftqjVhKcGJa7ZcFuOf3HMIpk+Hqbxkwg+77LlDA
	IGeEtQy+AGCagx8So/5Iiu4UtQ==
X-Google-Smtp-Source: AGHT+IH9POCXXZWRtQRhqbIqDlXwgNhDNOex4tdXVE7w2NANUENrUp1koUsAexp4kMfm8HYy5y/F9w==
X-Received: by 2002:a17:90b:1b52:b0:280:99ca:1611 with SMTP id nv18-20020a17090b1b5200b0028099ca1611mr10980882pjb.20.1700087412249;
        Wed, 15 Nov 2023 14:30:12 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id nr2-20020a17090b240200b0027d0de51454sm330562pjb.19.2023.11.15.14.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 14:30:11 -0800 (PST)
Date: Wed, 15 Nov 2023 14:30:11 -0800
From: Kees Cook <keescook@chromium.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Will Deacon <will@kernel.org>, agordeev@linux.ibm.com,
	aou@eecs.berkeley.edu, bp@alien8.de, dave.hansen@linux.intel.com,
	davem@davemloft.net, gor@linux.ibm.com, hca@linux.ibm.com,
	linux-arch@vger.kernel.org, linux@armlinux.org.uk, mingo@redhat.com,
	palmer@dabbelt.com, paul.walmsley@sifive.com, robin.murphy@arm.com,
	tglx@linutronix.de
Subject: Re: [PATCH v2 0/4] usercopy: generic tests + arm64 fixes
Message-ID: <202311151427.341BC07@keescook>
References: <20230321122514.1743889-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321122514.1743889-1-mark.rutland@arm.com>

On Tue, Mar 21, 2023 at 12:25:10PM +0000, Mark Rutland wrote:
> This series adds tests for the usercopy functions, which have found a
> few issues on most architectures I've tested on. The last two patches
> are fixes for arm64 (which pass all the tests, and are at least as good
> performance-wise as the existing implementation).
> [...]
>  lib/usercopy_kunit.c          | 506 ++++++++++++++++++++++++++++++++++

You didn't like lib/test_user_copy.c ? :)

There was a prior attempt to move it to KUnit:

https://lore.kernel.org/lkml/20200721174654.72132-1-vitor@massaru.org/

-- 
Kees Cook

