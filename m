Return-Path: <linux-arch+bounces-8106-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE2A99D7E3
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 22:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF7FB1F22331
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 20:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8F71CF5CF;
	Mon, 14 Oct 2024 20:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q6DGqB7J"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53A31CEACD
	for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2024 20:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728936514; cv=none; b=a2JQVhHrKboKl56msqeTpxZid1Yxn/mRZ3VGucIIycMaWZpUN2Oysf1DWEyR1JcgvY3dQKOFoA0ktVmCRQw9AgBf5S+eQntGJ0x3kYau6r0VYYIuh3E5O62OLLx812IVHMZ4i0lYua8KadvNi1SVTTy9Jr7fsxvgcBrn9maJ9Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728936514; c=relaxed/simple;
	bh=WJ0VNcaIc86VSheN53nKaNiPzg3nD5Htkqzr0j33dvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4rlbRBYEgym86Gm6YKEzvA1i3BtwY7lRjV5YqvCm1+Av+oqjrutNXbJYPkP5sY12Ptl2MEIB5gcD103sanC1Iwrux7150do1PBx4aNeED05FMyDzkqorFnFuhnBpVw2kbWWBm1W6GC/MGZADSPD2ETj1FAChQbJS1TcE1ZWDSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q6DGqB7J; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c93e9e701fso25648a12.1
        for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2024 13:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728936511; x=1729541311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJ0VNcaIc86VSheN53nKaNiPzg3nD5Htkqzr0j33dvg=;
        b=Q6DGqB7JajqCq8CaRLnnfsqrbPL2xad2Xek6z9bts+DgKIB5MAklE1x+TStSxLrPZ0
         Wn/kOHPj7ikNbfJzESPIfDjUck0tH4oonQ9XP62UDTohClvkH5LJK2sPq9xHDma4DIZW
         hFJe1Gdhi7m/NhljUXMIwSga1MejHmrtNqvtEtOtubv4trmLtvzr4ts+XcPbLTdTfFOP
         jbg2jPSUQgujFJUolAGIxzVHKzHcal+eK6oZWxiIBNAXEtOnfJosxOiJggh2wvTKtmmU
         mLZ4koIxtIIKo7l86rscM6+380tBm4a2UJPhMEpGDjSivjuPZEH5IatLdOGdA/evRiJ8
         sZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728936511; x=1729541311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJ0VNcaIc86VSheN53nKaNiPzg3nD5Htkqzr0j33dvg=;
        b=NyRXViY0S7K0EyF9p6Ac9ElIosJZTd2ybrJZs4TsyGjnVTswOPQpS7vCSTaEuNC9p+
         bHIOLnfhYzJTkiL9bBpNWV1bXK5hqMD5/g+e0GkNnjV6MHsv0rVlWWBulidOrKpOe7Hd
         b44gGPDWmH+v8BBkQtW/P9nloG+a+JqsphwC5hYcHEmU209sIlaS4ZCeqt0Aalkys4nL
         r9IKI3MnFGiV1f2wfGkxQ8mNs8x0GXBTedWeFF3dxvEVqlOs0lrQrqVZbs0IOS3Pw1sx
         KY/mIUX80N+MlHPA2w5cY1U+fOk+xP3QMMLT3ojiIQJ5s7SG8uygruHGlc94YeU7Uc8L
         O5UA==
X-Forwarded-Encrypted: i=1; AJvYcCWq9dY6+8m5yk/v5UHpqWXvnAkJ4i/GmF0euoBauidtl5u9/uxoABTAR9YvLkHUVZ9WLa4Xssi6qH5V@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk+Ou9FOY5O5+Pt9IkgjBJA519FI1DxGbv7+Uv8HnyMyCzYwii
	bLLVleySt0Ud8Ox3r80tobhQL5Sh9BZwYxrpIzZTOJJ6KJ06jABYT5+A2PJK9z56om3Im1t6ubu
	ktKu4fwhLFpxZ+nuPRlkuyQIroemi/YJ/Ir+5
X-Google-Smtp-Source: AGHT+IHzauMJXMRWtRoTmHGHhtdjUN1w4lIpDgvaCBZQpjqAMMmCxNje0X9NX0J+wmSkhigBY3I88y6VohWuT5HtooQ=
X-Received: by 2002:a05:6402:234c:b0:5c8:a0fd:64f0 with SMTP id
 4fb4d7f45d1cf-5c95b2c9139mr637583a12.2.1728936510371; Mon, 14 Oct 2024
 13:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903232241.43995-1-anthony.yznaga@oracle.com>
In-Reply-To: <20240903232241.43995-1-anthony.yznaga@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 14 Oct 2024 22:07:52 +0200
Message-ID: <CAG48ez0=9O-V0V6v_LUgRcF46BooJdk3eqb6xgDpKpNZuW1L2A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/10] Add support for shared PTEs across processes
To: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, markhemm@googlemail.com, 
	viro@zeniv.linux.org.uk, david@redhat.com, khalid@kernel.org, 
	andreyknvl@gmail.com, dave.hansen@intel.com, luto@kernel.org, 
	brauner@kernel.org, arnd@arndb.de, ebiederm@xmission.com, 
	catalin.marinas@arm.com, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org, 
	rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com, 
	pcc@google.com, neilb@suse.de, maz@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 1:22=E2=80=AFAM Anthony Yznaga <anthony.yznaga@oracl=
e.com> wrote:
> One major issue to address for this series to function correctly
> is how to ensure proper TLB flushing when a page in a shared
> region is unmapped. For example, since the rmaps for pages in a
> shared region map back to host vmas which point to a host mm, TLB
> flushes won't be directed to the CPUs the sharing processes have
> run on. I am by no means an expert in this area. One idea is to
> install a mmu_notifier on the host mm that can gather the necessary
> data and do flushes similar to the batch flushing.

The mmu_notifier API has two ways you can use it:

First, there is the classic mode, where before you start modifying
PTEs in some range, you remove mirrored PTEs from some other context,
and until you're done with your PTE modification, you don't allow
creation of new mirrored PTEs. This is intended for cases where
individual PTE entries are copied over to some other context (such as
EPT tables for virtualization). When I last looked at that code, it
looked fine, and this is what KVM uses. But it probably doesn't match
your usecase, since you wouldn't want removal of a single page to
cause the entire page table containing it to be temporarily unmapped
from the processes that use it?

Second, there is a newer mode for IOMMUv2 stuff (using the
mmu_notifier_ops::invalidate_range callback), where the idea is that
you have secondary MMUs that share the normal page tables, and so you
basically send them invalidations at the same time you invalidate the
primary MMU for the process. I think that's the right fit for this
usecase; however, last I looked, this code was extremely broken (see
https://lore.kernel.org/lkml/CAG48ez2NQKVbv=3DyG_fq_jtZjf8Q=3D+Wy54FxcFrK_O=
ujFg5BwSQ@mail.gmail.com/
for context). Unless that's changed in the meantime, I think someone
would have to fix that code before it can be relied on for new
usecases.

