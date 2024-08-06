Return-Path: <linux-arch+bounces-6067-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6897949A47
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2024 23:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A29285692
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2024 21:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69F115F409;
	Tue,  6 Aug 2024 21:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SemJxCq1"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F8F14C5A1;
	Tue,  6 Aug 2024 21:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722980183; cv=none; b=CXyWlovd3t7Y/jDt31HbnpJzWxSXW5XmVPVTDJfgPlgpWb7xakt6nl39PT6dfReiO2ZuuZYYiVd23vXHgKIdJqeswUQ/p92xZFCDYvtMSE/2s1SPxkyBE5FiXofYdFbfFs/PNQ5iXEqnjb26To0S/du5F7syunvzIZFOIaIKFjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722980183; c=relaxed/simple;
	bh=2t+WutVWb5K5+D7fiMz4bLOCIU3ZQR0TMlrkjEcV3Ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/9UB2h+KdSvLbzneFhslfDMqYPWVrutFTuRCcr9phnabJ3rcvtw5U+kicPyRZBn4M6QLEVw62EtXQHRWb5TYfEzdrh1axhghxZX9xId1uxmkkYLmJam5CSDN4BaLNsbOeURUXQGepxfuKMvPrjB5bagaJjHDq/D5Yw1dFumrEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SemJxCq1; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4f6ac1628dfso424924e0c.0;
        Tue, 06 Aug 2024 14:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722980181; x=1723584981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dh/CnSErYT7/6V79W9GXrn6y0woRRKH6f2DR4IxHNx8=;
        b=SemJxCq1iiNIrRCHDZzGFroL2IyUfxTOy1ZQ+Ov3aAOMFSNH2UW/10MR3kGh/Pr/GZ
         iMUlmcUCJVwUu9W0EcgWAXZIPmFmVVSgZlQuFk/8yLE+SeC1kghCi/FPDEEwFcKuTCog
         XgB4n3bF2VNcpF7MJzRdwpmX2qt7RiG5J6S/Aze1IcTGF+d43uXyJghyaTdWlNbmuSuk
         EfNPzhtM9HeCaPzgkZ8hT3is5zUgOkQb7/eQ0Nn9sF/Fksgktm+7T3yuH70+gcLTU41I
         7JoSX2yO8j323tepfhKEziLbWhIywTznisnsNNYjdjULdbtzqly4AVFtTbHVZPeZh5Si
         bCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722980181; x=1723584981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dh/CnSErYT7/6V79W9GXrn6y0woRRKH6f2DR4IxHNx8=;
        b=Kc4YuB2okayI2sj2ETwL3N7wQTNF7oiBVjvn1r0/WuaSDynlDR8lKVEG2OTz9YPXus
         V0IttrwuV6/5m5zpuUWVeUpQMnh99AFAJmp21AB4eU9b1l81+68LusD4Ax5TdIAoQMuQ
         hWcrnbtTMj/wtjExzu4Ie47pEwu9Ozzwr8v9FuC7fXzhX3ZWZhcyb8LvE2V5ZdI1RVKI
         kpj2ctFWaz87ytPQelmBm5pArTDibJC5ZEM6VWRkVAnvenTTaPaonoiqrxN9L9VyZY2/
         q/kdmzqopMc6FBAy8eUtn92/BkA59F0AVn1Pv1zfiG9oqq1HenoK1VuCuYAmNixO0vyN
         XPqA==
X-Forwarded-Encrypted: i=1; AJvYcCW7cBLGUZQYgxMC6P/3KTVZgKAfPZvQfw9P3JgAchkkbA2YfSiMX04ABQQtRCIbABi9tN/e2qu7rVvavESmbu1YZTKZtQz1a45JbzdDRJ3fnH0doLrGiSpih9bLCmGUVytthevX9KXG7zXtG5raBXyNIxmRKRW3Altds/2kSQwWBv0=
X-Gm-Message-State: AOJu0YyTYuAwSjWF3a7zxV4lqX85xNFuQZm3bU3tWV/S1Msr32kLSAPN
	pJ8c/7QfyiFzOcb1ItO1YsghNxnNKWzQ3p1zwFtMYX+ZhWopSKyQ47nHYg0I3LpM3xy4x/9G7HF
	6xSDJd1j2lt/eYjFbZri2f5B0M0Y=
X-Google-Smtp-Source: AGHT+IFmUCpFy0ikEOsHVNcJ0/zIKB6zFAVRuMB81ZBEkWgUduwTajthzToYqvIUNMbqXOXZ0iKU7UA3pdcWrBARjqM=
X-Received: by 2002:a05:6102:6d4:b0:492:a11f:a878 with SMTP id
 ada2fe7eead31-4945bebdc3dmr20433130137.23.1722980181051; Tue, 06 Aug 2024
 14:36:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731133318.527-1-justinjiang@vivo.com> <20240731091715.b78969467c002fa3a120e034@linux-foundation.org>
 <dbead7ca-e9a4-4ee8-9247-4e1ba9f6695c@vivo.com> <20240806133823.5cb3f27ef30c42dad5d0c3e8@linux-foundation.org>
In-Reply-To: <20240806133823.5cb3f27ef30c42dad5d0c3e8@linux-foundation.org>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 7 Aug 2024 04:32:09 +0800
Message-ID: <CAGsJ_4x1tLEmRFbnUYcNYtV73SyBYpBtAx_syjfcnjrom-R+4w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] mm: tlb swap entries batch async release
To: Andrew Morton <akpm@linux-foundation.org>
Cc: zhiguojiang <justinjiang@vivo.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-arch@vger.kernel.org, cgroups@vger.kernel.org, 
	kernel test robot <lkp@intel.com>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 4:38=E2=80=AFAM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Thu, 1 Aug 2024 14:30:52 +0800 zhiguojiang <justinjiang@vivo.com> wrot=
e:
>
> > > Dumb question: why can't this be done in userspace?  The exiting
> > > process does fork/exit and lets the child do all this asynchronous fr=
eeing?
> > The logic optimization for kernel releasing swap entries cannot be
> > implemented in userspace. The multiple exiting processes here own
> > their independent mm, rather than parent and child processes share the
> > same mm. Therefore, when the kernel executes multiple exiting process
> > simultaneously, they will definitely occupy multiple CPU core resources
> > to complete it.
>
> What I'm asking is why not change those userspace processes so that they
> fork off a child process which shares the MM (shared mm_struct) and
> then the original process exits, leaving the asynchronously-running
> child to clean up the MM resources.

Not Zhiguo. From my perspective as a phone engineer, this issue isn't relat=
ed
to the parent-child process or the wait() function. Phones rely heavily on
mechanisms similar to the OOM killer to function efficiently. For instance,
if you're using apps like YouTube, TikTok, and Facebook, and then you
open the camera app to take a photo, the camera app becomes the foreground
process and demands a lot of memory. In this scenario, the phone might
decide to terminate the most memory-consuming and less important apps,
such as TikTok or YouTube, to free up memory for the camera app. TikTok
and YouTube become less important because they are no longer occupying
the phone's screen and have moved to the background. The faster TikTok
and YouTube can be unmapped, the quicker the camera app can launch,
enhancing the user experience.

An important reason why apps can launch very slowly is due to the time late=
ncy
of alloc_pages(). That's why I'm quite interested in Zhiguo's patchset. On =
the
other hand, mTHP can help alleviate the situation by releasing swap slots t=
hree
times faster in my other patch:
https://lore.kernel.org/linux-mm/20240806012409.61962-1-21cnbao@gmail.com/

This is likely another advantage of mTHP.

Thanks
Barry

