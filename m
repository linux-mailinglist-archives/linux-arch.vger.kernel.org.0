Return-Path: <linux-arch+bounces-4379-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 860078C47E7
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 21:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2C201F22BCF
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 19:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FD97BB0C;
	Mon, 13 May 2024 19:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LbB+OgtX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEC279B7E
	for <linux-arch@vger.kernel.org>; Mon, 13 May 2024 19:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715630117; cv=none; b=SFNl/lYcosj/bFJCvbTYB6XEOvJDWs8PcaEFxjIhGAUSp76LWX60BMbnxqOCrhLAZtbtT3rtK3EDEEbXhtFr/COFQcQa89oZbfm6rg888oMxmPbhW38RGqRMd+wx+CD994sGRyVPjSwMUuBa0Nc99SDUwsatFxJJxmNuaS/63pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715630117; c=relaxed/simple;
	bh=uBD+lCS1DaJg6jKg9TthY1YebWwqH1WdbY89Bs+ieEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VkB2G6GFHpCjyrY5TChQ8YizoZAtASn66IvVcrhNLDlcHHrkA5hPx1uKZRnH1oqAXxCXYmddCpbk2jHKu/tdMk2SShQ6HPwEe7agFb+QNsh2U/nbJUnPV6rJUK5jI56pOSVbzkV7xMYvt/hBBOVGJAJBVvPGLUWjXoJ6oNNuikA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LbB+OgtX; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4df9b81502eso572836e0c.2
        for <linux-arch@vger.kernel.org>; Mon, 13 May 2024 12:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715630114; x=1716234914; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+L/QJAKhm4Sma54bKYWeDhRohm5ZmYTjH6drv8r9LS0=;
        b=LbB+OgtXPsRxrqha6lI297oWOvuDTIEjkmyAPFd2SrHxe0CN+hkNJz0sb5PKb8PsTi
         6atRt4hj0qsW52ENIZjfUwx1qLcR4n+F47/YAnTT3qjZuW/TMnGNOp06qs7KscmNwvWu
         N8jMGvXT4KKLTjs2MQKn3SLbv7rjGO5P1HaqnPFrnYUtri7AyVSovhR+1YfQ8hX7HsO6
         jL1RZG4dB9xdythpMtNDPgO89j79jtbNueIU5OYLrRllnbQAIoOuiBdjelqfNbQdfZIE
         76bBzMh07lUMjAzaqXAqkXdk2TLlQFyLLjKOwX5eC6XDih9p+MOEMtG+U95cn96SbFWk
         haaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715630114; x=1716234914;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+L/QJAKhm4Sma54bKYWeDhRohm5ZmYTjH6drv8r9LS0=;
        b=WtAGR+yF/xWFcr3IsI7VK6l8366GBGX9x5+oGj6jp1ELtCpdGenbiWkP2uoBYKMX5a
         R0WL9xdIa3LCcxr3enHVprtCA8AwPqY3/YFs5c26KPCuyOzIT5bFlmP5iLGfvHqBEKoz
         7oepqaAcfyUfnnJWSqnYRH9tOf1dsK1dkUromE66dwlIALGpxFcJhf6FqLHPCJoT7WLw
         eGm+qnNagBaevHUp8vlAoFf7kgZwWVe233hj8zy2DVDRIpshKVAdLB+mFwONNL0RnfhA
         bzjrFdqky6JujRqd5LunMBsVE8XPnzP7ZvzM9QFfq1I6qVr5GNaMwoJglMTJ/YHqDFdM
         C3/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzW+qX+OPOh1D+boo3NbNQhQIAfHdxGIVcaUg+S8Fp+hw+9rFK9LVL7jY3aF1TixXkSlkSyBDTIfW0N24SOS7TZZXN3Mct0YGF3A==
X-Gm-Message-State: AOJu0Yw6Pfon+fsFRKkwp8l7eftRYcFI+JmmzkCZI6vjTQ7oJaDz7ADU
	kgsq+JvGuaOOhVrTF04set5smZpt8HZzutCPTznenocMyvUjeLTFVNhi7vZQfGX78CtgkdUqcEx
	hDcQQnS/4JKoHJOc6GUJlyNqGObNOB1dGKIUBnmSOt2Fh217/kA==
X-Google-Smtp-Source: AGHT+IHBfL9nuJIR67+Dnqw5wB6Py3NFwg023YfGr3BJHR42tIbXrkbks+bKtlytsKenkm7r5WJtqIs8zzzvxGrTaas=
X-Received: by 2002:a05:6122:922:b0:4d3:39c3:717c with SMTP id
 71dfb90a1353d-4df88286086mr8285451e0c.1.1715630114304; Mon, 13 May 2024
 12:55:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506133544.2861555-1-masahiroy@kernel.org> <202405131136.73E766AA8@keescook>
In-Reply-To: <202405131136.73E766AA8@keescook>
From: Marco Elver <elver@google.com>
Date: Mon, 13 May 2024 21:54:38 +0200
Message-ID: <CANpmjNO=v=CV2Z_PGFu6ChfALiWJo3CJBDnWqUdqobO5X_62cA@mail.gmail.com>
Subject: Re: [PATCH 0/3] kbuild: remove many tool coverage variables
To: Kees Cook <keescook@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Peter Oberparleiter <oberpar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, Johannes Berg <johannes@sipsolutions.net>, 
	kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 May 2024 at 20:48, Kees Cook <keescook@chromium.org> wrote:
>
> In the future can you CC the various maintainers of the affected
> tooling? :)
>
> On Mon, May 06, 2024 at 10:35:41PM +0900, Masahiro Yamada wrote:
> >
> > This patch set removes many instances of the following variables:
> >
> >   - OBJECT_FILES_NON_STANDARD
> >   - KASAN_SANITIZE
> >   - UBSAN_SANITIZE
> >   - KCSAN_SANITIZE
> >   - KMSAN_SANITIZE
> >   - GCOV_PROFILE
> >   - KCOV_INSTRUMENT
> >
> > Such tools are intended only for kernel space objects, most of which
> > are listed in obj-y, lib-y, or obj-m.

I welcome the simplification, but see below.

> This is a reasonable assertion, and the changes really simplify things
> now and into the future. Thanks for finding such a clean solution! I
> note that it also immediately fixes the issue noticed and fixed here:
> https://lore.kernel.org/all/20240513122754.1282833-1-roberto.sassu@huaweicloud.com/
>
> > The best guess is, objects in $(obj-y), $(lib-y), $(obj-m) can opt in
> > such tools. Otherwise, not.
> >
> > This works in most places.
>
> I am worried about the use of "guess" and "most", though. :) Before, we
> had some clear opt-out situations, and now it's more of a side-effect. I
> think this is okay, but I'd really like to know more about your testing.
>
> It seems like you did build testing comparing build flags, since you
> call out some of the explicit changes in patch 2, quoting:
>
> >  - include arch/mips/vdso/vdso-image.o into UBSAN, GCOV, KCOV
> >  - include arch/sparc/vdso/vdso-image-*.o into UBSAN
> >  - include arch/sparc/vdso/vma.o into UBSAN
> >  - include arch/x86/entry/vdso/extable.o into KASAN, KCSAN, UBSAN, GCOV, KCOV
> >  - include arch/x86/entry/vdso/vdso-image-*.o into KASAN, KCSAN, UBSAN, GCOV, KCOV
> >  - include arch/x86/entry/vdso/vdso32-setup.o into KASAN, KCSAN, UBSAN, GCOV, KCOV
> >  - include arch/x86/entry/vdso/vma.o into GCOV, KCOV
> >  - include arch/x86/um/vdso/vma.o into KASAN, GCOV, KCOV
>
> I would agree that these cases are all likely desirable.
>
> Did you find any cases where you found that instrumentation was _removed_
> where not expected?

In addition, did you boot test these kernels? While I currently don't
recall if the vdso code caused us problems (besides the linking
problem for non-kernel objects), anything that is opted out from
instrumentation in arch/ code needs to be carefully tested if it
should be opted back into instrumentation. We had many fun hours
debugging boot hangs or other recursion issues due to instrumented
arch code.

Thanks,
-- Marco

