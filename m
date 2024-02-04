Return-Path: <linux-arch+bounces-2078-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E3C848D35
	for <lists+linux-arch@lfdr.de>; Sun,  4 Feb 2024 12:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7181F22380
	for <lists+linux-arch@lfdr.de>; Sun,  4 Feb 2024 11:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED452224C2;
	Sun,  4 Feb 2024 11:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gvDqrOcG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E925F22313
	for <linux-arch@vger.kernel.org>; Sun,  4 Feb 2024 11:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707047134; cv=none; b=EzhWHyjkZm4w3llapr3B37P4uvIzZUq3BrV1GIFGQ36X5qjaMbGDNtnM4xRXRMaYe4wueh9swuv79VmHWcVTnjSRXOO919GC1g6/S1gcTyozXl5IySCJSKZQWR1hqqt9x4fCKm0BwnbQEO/DvMhdLPm0r7mglJhw2GxrlwX5hdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707047134; c=relaxed/simple;
	bh=qgF9mgJuwBON3XPXrWsmUJR+tGrDKBmgIGDGKxUWbwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+bOXBYZJ+gwwAA16WV7Jl3YPFEwy7WXfEOUsO743jnc/fWovrQc0wJ6jEz74TuPr69IF2BdfQE9fv6nrJ2LyQfkvMYLRxV3TPzONQYAbmec9xOReG7gL+odrn/2y1iBkVQIGLv3c6aXN+epNnz1/npHkumvzOh07boB7evU9k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gvDqrOcG; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a370e7e1e02so211354666b.0
        for <linux-arch@vger.kernel.org>; Sun, 04 Feb 2024 03:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1707047131; x=1707651931; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VWi8x1miBJ1PGJBMtpIeIYYJwAHPliiF8cHXBoeQK6g=;
        b=gvDqrOcGI+qfW2Yg1FJSAzMhM5mvboG757dGgBtsDT0Lh5JQWT6oeHO58uMWtg4ow9
         UQkRjgYXyTq1p6kDCKMASLMum4BM5tHsWDN9JV5ghrKi/5HW/kvbDbuVZtke3CI1rdgd
         X7aOOM0hEbdRGMjYLjcO7fd2BID/J5GN8L1Yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707047131; x=1707651931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VWi8x1miBJ1PGJBMtpIeIYYJwAHPliiF8cHXBoeQK6g=;
        b=gEy9Mt9q/BRxkNWObCXAf3x5/3NKDEgGbptbf1jAl0O9WjiEPK3rpAB/KMoSczJR2w
         i1Uq2z6Z5R5jkQbWUaQ+hCdk7CjXj3BMRKghJxIH25UUYGgSsnLx956Njpy3be6vS1wN
         PnRRAIXgKBqkT+uZT2euW28CSe2zPoI98O3vk3p7dKeibX8izUwy86/Cj4JBx7lW6oCD
         QwcoDHgXupPvF1JyznMmaURflyhQrcANPj0WqiK5aQp1yTxK7tGtcuvoSVqmjtV/iBHP
         7lGzYkG9n9T+/MkZTu6/iYjuvJkB3n7EOdh2F8FnHqI3n2ecbgPlVhWDqrVWllRtVd2j
         d49Q==
X-Forwarded-Encrypted: i=0; AJvYcCXmuo1JB29wlbjPDnM+gsrt5cdSBQHqk4AezKAsD2VpVIfKxJp0tC3/n144I8FrhzqWtCeJlncEe1RXt/t020kws9Psxc/YVvihaQ==
X-Gm-Message-State: AOJu0YwdP3FwijuoWCGfU1V62mVYn3wuwxarbIj9ieAs4SPMhjiBG2xQ
	RW1X5Q1Z1fBcd+0rfRLol3TbGvt3XTjFSHMpDBcmeQ5ElmWe5iKPyflBhDGfNwcMqpoiTLd0jQP
	0VOg=
X-Google-Smtp-Source: AGHT+IGfpDfQb0x3CY+SpNkppZfeae1fjI1Ed5eL5Pj20Epq+xTS/OHFR+qHe6IJYwB/hsslNjkK8A==
X-Received: by 2002:a17:906:1c59:b0:a37:69d4:b392 with SMTP id l25-20020a1709061c5900b00a3769d4b392mr2456663ejg.2.1707047130953;
        Sun, 04 Feb 2024 03:45:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWZqnHZEoCVrGQ0Co24S8KNJUx46iz1kuaCTweBg3HLYp+PORjLigStQQilhmxrAEM2xX3sPbfUXjYFflyYp5uoPG2gxetqgfuCUQ==
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a26f1f36708sm3046128ejc.78.2024.02.04.03.45.29
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 03:45:29 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56003c97d98so1852842a12.3
        for <linux-arch@vger.kernel.org>; Sun, 04 Feb 2024 03:45:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUbcVYx2H8MT5cPKa1Q5iWRBYOrdt1E/MuFBOlwh4CsGx3+jzx1mlPNKxHZchgLauMuSxuOcbAgjwHIIi4wwCL5cm+VnBU27r/0lg==
X-Received: by 2002:aa7:d294:0:b0:55f:8bba:d0ae with SMTP id
 w20-20020aa7d294000000b0055f8bbad0aemr3329700edq.23.1707047129481; Sun, 04
 Feb 2024 03:45:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202-exception_ip-v2-0-e6894d5ce705@flygoat.com>
 <CAHk-=wiaSjYApqmUYCdCyYfr_bRsfVKDkwU6r6FMmoZzrxHrKQ@mail.gmail.com>
 <eeb92d70-44d6-47f4-a059-66546be5f62a@flygoat.com> <CAHk-=wiUb1oKMHqrxZ6pA7OjNmtgw6giTKWiagUC2kt-ePCakg@mail.gmail.com>
 <716af17c-136b-4852-86ce-a23bafe34fbb@flygoat.com>
In-Reply-To: <716af17c-136b-4852-86ce-a23bafe34fbb@flygoat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 4 Feb 2024 11:45:13 +0000
X-Gmail-Original-Message-ID: <CAHk-=wjvt75XFUWxPQQJZE0Wdi8HtSLtqQm2L-ZrqH7=2g3ByQ@mail.gmail.com>
Message-ID: <CAHk-=wjvt75XFUWxPQQJZE0Wdi8HtSLtqQm2L-ZrqH7=2g3ByQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Handle delay slot for extable lookup
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Ben Hutchings <ben@decadent.org.uk>, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	Xi Ruoyao <xry111@xry111.site>
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 Feb 2024 at 11:03, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> Well this is the tricky part of my assumption.
> In `exception_epc()` `__isa_exception_epc()` stuff is only called if we
> are in delay slot.
> It is impossible for a invalid instruction_pointer to be considered as
> "in delay slot" by hardware.

Ok, I guess I'm convinced this is all safe. Not great, and not exactly
giving me the warm fuzzies, but not buggy.

         Linus

