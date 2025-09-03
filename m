Return-Path: <linux-arch+bounces-13370-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CD2B42D66
	for <lists+linux-arch@lfdr.de>; Thu,  4 Sep 2025 01:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E8347C5490
	for <lists+linux-arch@lfdr.de>; Wed,  3 Sep 2025 23:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081802EBDD0;
	Wed,  3 Sep 2025 23:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iuys6/KI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A31526F463
	for <linux-arch@vger.kernel.org>; Wed,  3 Sep 2025 23:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756942116; cv=none; b=QN5qmD9TScvXiRg2CzsJJ5FbMB3JW+/PHcxGPHuhyEfkjQ1deKyjcSoaSogB6c+o8pMdeU6C3fARLrVwm37ra6dsXFIXmVkwZfNe9ePmE0FcWuNUtbJIu1iWBTbCXMVi/RxUUIihtdXo1vXoDJC5gRmpGxJK0Gzbi9RU3dPpnYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756942116; c=relaxed/simple;
	bh=UqjqachRXn1HwRELgrBTL2T9lUKqgqiaiITgVWtzg+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nXFCC5KnaIkrDtpCJde/e5rDMvuWXTDMmLP1gYqzHBp3Iul6eoU1mvn9PR89xGIqEqMerDWQHdB+ckqlxl4Wo4u2jsqqljEJ4mXYUpv75OmyQF4GO7JHBfuFXZsQC0CGWSC1mug/g5/McFw4vcoS1IOHqKzCgVcExrcvZh+It+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iuys6/KI; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e96e892081eso462935276.3
        for <linux-arch@vger.kernel.org>; Wed, 03 Sep 2025 16:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756942114; x=1757546914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqjqachRXn1HwRELgrBTL2T9lUKqgqiaiITgVWtzg+A=;
        b=iuys6/KIqUOEXkJw0+/P7iyJGL10Ie4+pzhYF7wqZ977sNzQDVcahMNMjhoL2YPn+E
         8P7VxOBjHwdm3wVghLH08/1NZ5Oq/w1FiPa3B+qO2hYkjQi6o0qOYNzygiClPSc7fi4S
         2XD6otmiWUPl+vXmAWqRM5YTM03CsGV+ZE9AqthuKUJdZ1WX5usSoMTtrOZ7pUs2dxPY
         ncp/2/5XRPxFF1XrmwlPoJ3bFq8HbGtM/H0iFon7R5xEqp4w0FP8e+LhD8e+rwIlBvDr
         suSA5l2UzjIDuD/ec4FS9ZDRCTo2fVFVWBYndHw+sxxiMqpkqn68/I6i4DNmibbiKH68
         FtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756942114; x=1757546914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UqjqachRXn1HwRELgrBTL2T9lUKqgqiaiITgVWtzg+A=;
        b=cUnQl+X2w37PvsbyBgOKhsoRahGoWyMIOBMazptnszK7NFKTVxsq1UVBk3wNKNc7eW
         Alt1wilGAfKTtfEgDHFgi4B8j05tl3ZXwJYhxuKKxDgvXx1u0II90imvxR6qH/rC3zJg
         Q7eKNYYZU0yyxuwcDtgn3/0qZ9zTtncKoSEfMqUS1bJvROR0n27IPtXJaqwLyJdi59LR
         sqvpypclfHpj/dA76fgAPK/1+esmSPxcc8zasiujdpE7kpXK+oNJdVXYhxFpI9QrvDCC
         hFEM8nyE2PUaNNKvWRgAG0GIead2RujInpC88MckEhV9epGiIHmkOOqzShoWZpuAXGds
         /ccg==
X-Forwarded-Encrypted: i=1; AJvYcCWXWMngNoOU6+XXfEmYFuMRl9dBdfQBFeq/v7drxFRZWD6ETmcm1spcbZr9oApo/CjefLsCc2L3K60U@vger.kernel.org
X-Gm-Message-State: AOJu0Yycmsw/+AMYXKTh0NMSLWc1YrCQkTOmHOeGeAwpHKPCo1jPFiPb
	rd4ayWhhqg0Lxb0YRYFViwLjAtueAChOBM4cCLDLGSQnXXBfQvYnizu3yTVWCQ9smuY9BOSZcKm
	GCtyoe9bO/EMFi3XbqmAcC6HBrP/m2iNlFgVl/Ir4
X-Gm-Gg: ASbGncu7Fc5xU2pjgWhfR9HtrxyZToShUr6FrAUe3ZdRkJmj44oVvphkO6eGbCD+Rbl
	a5CaBYlqxJuIQvfl7NYjpcOYyxse6H5QqHskCTNL4IaQjnByqKfJBgPnonxt9mFYPY+VJIdn6Ip
	wRAFppYaJegQwIZyJBeAUJmjbjfGa3YVxXoLGHUczWiSIkLZEDESsAok0tMYj8RnKErFHAhJR7b
	3CGTOhpHn3ZYeHJjBr6IuHzLNM=
X-Google-Smtp-Source: AGHT+IGlPIP8oLtiC4wG5WrNKAc4UwbWQI9iei+N+57tKkTFJtqNCENNeZckB8ql+MwlRO5lsU8KOzVn8PEgh9nTxlA=
X-Received: by 2002:a05:6902:284a:b0:e9b:b6aa:98dd with SMTP id
 3f1490d57ef6-e9bb6aaa0fcmr12868850276.5.1756942113989; Wed, 03 Sep 2025
 16:28:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829105418.3053274-1-sidnayyar@google.com> <4e215854-59df-489b-b92d-8d2fb2edf522@suse.com>
In-Reply-To: <4e215854-59df-489b-b92d-8d2fb2edf522@suse.com>
From: Sid Nayyar <sidnayyar@google.com>
Date: Thu, 4 Sep 2025 00:28:22 +0100
X-Gm-Features: Ac12FXwP9jzMz1FEtiEYhrSL5bEOit-gvEx4axvwyPrGNk7vWuUT6_L_wldOkSQ
Message-ID: <CA+OvW8ZY1D3ECy2vw_Nojm1Kc8NzJHCpqNJUF0n8z3MhLAQd8A@mail.gmail.com>
Subject: Re: [RFC PATCH 00/10] scalable symbol flags with __kflagstab
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Giuliano Procida <gprocida@google.com>, =?UTF-8?Q?Matthias_M=C3=A4nnich?= <maennich@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 1:27=E2=80=AFPM Petr Pavlu <petr.pavlu@suse.com> wro=
te:
> Merging __ksymtab and __ksymtab_gpl into a single section looks ok to
> me, and similarly for __kcrctab and __kcrtab_gpl. The __ksymtab_gpl
> support originally comes from commit 3344ea3ad4 ("[PATCH] MODULE_LICENSE
> and EXPORT_SYMBOL_GPL support") [1], where it was named __gpl_ksymtab.
> The commit doesn't mention why the implementation opts for using
> a separate section, but I suspect it was designed this way to reduce
> memory/disk usage.
>
> A question is whether the symbol flags should be stored in a new
> __kflagstab section, instead of adding a flag member to the existing
> __ksymtab. As far as I'm aware, no userspace tool (particularly kmod)
> uses the __ksymtab data, so we are free to update its format.
>
> Note that I believe that __kcrctab/__kcrtab_gpl is a separate section
> because the CRC data is available only if CONFIG_MODVERSIONS=3Dy.
>
> Including the flags as part of __ksymtab would be obviously a simpler
> schema. On the other hand, an entry in __ksymtab has in the worst case
> a size of 24 bytes with an 8-byte alignment requirement. This means that
> adding a flag to it would require additional 8 bytes per symbol.

Thanks for looking into the history of the _gpl split. We also noted
that there were up to five separate arrays at one point.

We explored three approaches to this problem: using the existing
__ksymtab, packing flags as bit-vectors, and the proposed
__kflagstab. We ruled out the bit-vector approach due to its
complexity, which would only save a few bits per symbol. The
__ksymtab approach, while the simplest, was too wasteful of space.
The __kflagstab seems like a good compromise, offering a slight
increase in complexity over the __ksymtab method but requiring only
one extra byte per symbol.

> >
> > The motivation for this change comes from the Android kernel, which use=
s
> > an additional symbol flag to restrict the use of certain exported
> > symbols by unsigned modules, thereby enhancing kernel security. This
> > __kflagstab can be implemented as a bitmap to efficiently manage which
> > symbols are available for general use versus those restricted to signed
> > modules only.
>
> I think it would be useful to explain in more detail how this protected
> schema is used in practice and what problem it solves. Who is allowed to
> provide these limited unsigned modules and if the concern is kernel
> security, can't you enforce the use of only signed modules?

The Android Common Kernel source is compiled into what we call
GKI (Generic Kernel Image), which consists of a kernel and a
number of modules. We maintain a stable interface (based on CRCs and
types) between the GKI components and vendor-specific modules
(compiled by device manufacturers, e.g., for hardware-specific
drivers) for the lifetime of a given GKI version.

This interface is intentionally restricted to the minimal set of
symbols required by the union of all vendor modules; our partners
declare their requirements in symbol lists. Any additions to these
lists are reviewed to ensure kernel internals are not overly exposed.
For example, we restrict drivers from having the ability to open and
read arbitrary files. This ABI boundary also allows us to evolve
internal kernel types that are not exposed to vendor modules, for
example, when a security fix requires a type to change.

The mechanism we use for this is CONFIG_TRIM_UNUSED_KSYMS and
CONFIG_UNUSED_KSYMS_WHITELIST. This results in a ksymtab
containing two kinds of exported symbols: those explicitly required
by vendors ("vendor-listed") and those only required by GKI modules
("GKI use only").

On top of this, we have implemented symbol import protection
(covered in patches 9/10 and 10/10). This feature prevents vendor
modules from using symbols that are not on the vendor-listed
whitelist. It is built on top of CONFIG_MODULE_SIG. GKI modules are
signed with a specific key, while vendor modules are unsigned and thus
treated as untrusted. This distinction allows signed GKI modules to
use any symbol in the ksymtab, while unsigned vendor modules can only
access the declared subset. This provides a significant layer of
defense and security against potentially exploitable vendor module
code.

Finally, we have implemented symbol export protection, which prevents
a vendor module from impersonating a GKI module by exporting any of
the same symbols. Note that this protection is currently specific to
the Android kernel and is not included in this patch series.

We have several years of experience with older implementations of
these protection mechanisms. The code in this series is a
considerably cleaner and simpler version compared to what has been
shipping in Android kernels since Android 14 (6.1 kernel).

I hope this clarifies the goals of the patch set. Let me know if you
have further questions.

--
Thanks,
Siddharth Nayyar

