Return-Path: <linux-arch+bounces-4268-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4612A8C00F2
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 17:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670D61C23F39
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 15:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A187E0F0;
	Wed,  8 May 2024 15:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZanAVOBC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7419254FA3;
	Wed,  8 May 2024 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715182112; cv=none; b=YK5Mv6OIrFHgbArPuCPUls4aojok/gtbdmRfXbMGJ3PDL/B4IYOrMe7svuOL7Qkkj1HzYpcG7HZKrm5FqdwDeOMrkGxTEdj4P8yVimBSu5jkN1VJuAH0WQ9fQ28zPXz5J6oScZU89FoWnbU0BSK/KQ4eBPdkMiCvL+C/QQWXa4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715182112; c=relaxed/simple;
	bh=eJdRlKINTI3nwir94KxbYJZKfQ363M1bgd4/u6O/p44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7SzgSJQ6tSoIY6PeywEqe6NuJDOVNBKWoBX28aiIUqGZVvxATxi4YxHIG2RQ+xberkpAOSoLBKe5fPdsk5p7Uv/sufx0TgJ65/CcsbkbYo0LeuSM+lPnwu3i/IXqVoxyxooLSKRV0/6V4H1JArpUhGhdpGIMmkxGLQy+KnxBNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZanAVOBC; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-572e48f91e9so297122a12.0;
        Wed, 08 May 2024 08:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715182109; x=1715786909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=awBb3eNnF3VVi2Uas+dc27Pk+UeJuDW1wWnsL0tI4xc=;
        b=ZanAVOBC1J/ie8u27+uSKgvFr0U0Qvilc2HtsabQoyyemVvTwy93LShmCaocYKESYK
         BqzwuPq0klabxRz3WuVPQ3VUbiKhQ+EjSS9EPnY4/LXXPClZIhsFUIJgKNPnqyOhoGVO
         YCe15ihIO827fFPvH9BN/YE6t1uyDAX3omqfSvYZgowgTSbXqC1tdLADA25tXf8OPNvc
         cItEzO4Yx2Ce7qAF+H7pvVtF75a1YaC+FVNMNQTd9tmqU8RA/Mo8/0lI+FmgZjY/4fyo
         726Tv1xqi7z9aQ0JSAolN/pIWRtavPYrnbgSgrYbWP7yum+NIDvbRR2wxhu2cQNXbhwY
         J/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715182109; x=1715786909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awBb3eNnF3VVi2Uas+dc27Pk+UeJuDW1wWnsL0tI4xc=;
        b=aIGMda8zqf+v+NGpVlgqawsMJd6v4mudjpT/bIjcIugKUyTUqwER19BXlcpbiGcH/9
         ZIhHMXIv7/xZIsl4fJl0OSSMNmubLfTG5/wXMsiGQW9VizF0PTsPIcqHgA6TLcdkv9Z1
         S47HwE9nkSptkXBCwTwBshAMJs/LwFhzz1q7z7d8yzwSo3zGq1++YC9/tjwJNX+jjWre
         dxVb/gpnKSjCvupeQQnwbeRIyusRJ2+XdlwuYYI4urNXHrXxUKBGk78liKuK+doW151S
         AnEs4Sf4uMX2kK8gVBe8uSbJ3+HWtzotwIXzXirlJqDrr7N0pljYVrYzmKC6raHT6oiF
         H76g==
X-Forwarded-Encrypted: i=1; AJvYcCVqnU231KXfeVKWEt7Hq6zBc2oULNoaIEnM0/DpTns7oi+uPMFE3YK22F52ByE37lu6hZc8mn++OfnF9xcaOsXeuylpHKeTeL8CL/s7gg+H9wzZNYfjXlFJPPscnxy361DqVDhSA/NBEw==
X-Gm-Message-State: AOJu0YxvTqxTqM4ufBPBRp3NUmmpne/9MmIOy9GN+3GXNkmCl+vmfn2R
	JXVJg6OdxetT8Xpx6zsmILPSu8+rPA5M4BzR1YU+WJsd3FrZgJup
X-Google-Smtp-Source: AGHT+IGWqN+QIxf9faE1NevIgjYKVvw9kBJMn0fiVzOWA9Ee8TjRiZGmml19TYo7R5DOZS0n/cU/7A==
X-Received: by 2002:a50:d685:0:b0:572:6ee9:5a37 with SMTP id 4fb4d7f45d1cf-5731d9b5eaemr2113007a12.11.1715182108540;
        Wed, 08 May 2024 08:28:28 -0700 (PDT)
Received: from andrea ([31.189.114.81])
        by smtp.gmail.com with ESMTPSA id o5-20020aa7c7c5000000b00572c25023b1sm7685797eds.0.2024.05.08.08.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 08:28:28 -0700 (PDT)
Date: Wed, 8 May 2024 17:28:22 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	puranjay12@gmail.com
Subject: Re: [PATCH] tools/memory-model: Add atomic_and()/or()/xor() and
 add_negative
Message-ID: <ZjuaFmFMloYqq1PS@andrea>
References: <20240508143400.36256-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508143400.36256-1-puranjay@kernel.org>

On Wed, May 08, 2024 at 02:34:00PM +0000, Puranjay Mohan wrote:
> Pull-849[1] added the support of '&', '|', and '^' to the herd7 tool's
> atomics operations.
> 
> Use these in linux-kernel.def to implement atomic_and()/or()/xor() with
> all their ordering variants.
> 
> atomic_add_negative() is already available so add its acquire, release,
> and relaxed ordering variants.
> 
> [1] https://github.com/herd/herdtools7/pull/849
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Acked-by: Andrea Parri <parri.andrea@gmail.com>

Thanks,
  Andrea

