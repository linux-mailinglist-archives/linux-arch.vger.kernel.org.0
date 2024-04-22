Return-Path: <linux-arch+bounces-3901-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F278AD4AE
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 21:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E463280F86
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 19:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C9A155322;
	Mon, 22 Apr 2024 19:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7ZSZoI2"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA601DFFB;
	Mon, 22 Apr 2024 19:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713813430; cv=none; b=NefindJ92ura3clEBclDtn6QyWojClgySZfkWZ/Mfhet+LnYPoaBirq34Jk+BvOysWCEnZNUQMzWrrp7xUlrQJaZpbupoUScqjuv8zY8mfX+Id6nYtIb5/SzF/a5No4k5YMP79Hm/6OiOWo2UECSI2bfa7ZeakuW/qrwkj9Z7UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713813430; c=relaxed/simple;
	bh=lHeD1D8H/MmEcMeeZUI4LjzVYUL80F8jZcOEKkoujmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hMf0EhcTQIWEmZTv7yEqhoSLnYknfC//OI2TSzyWwxPRu2Cs/JocW+eQZ8H82RzF6X/Zw89DoxhOaWsQW5Zv+uzWW+vYjKqLvdi8Dk6Fa/w3y54BR6KKBBs1SM/IlNP3Q41FOWVSZlx6bhRPvgR75e8scOspIRjjnXCVMccbVz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7ZSZoI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F17AC4AF08;
	Mon, 22 Apr 2024 19:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713813429;
	bh=lHeD1D8H/MmEcMeeZUI4LjzVYUL80F8jZcOEKkoujmU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b7ZSZoI2D2X7HToN0E2f+jHBxNlm4eQzdNjbZ10yTbZjs1FKmOK9k1iO6QPgtz2xp
	 8QejgxtE7KQUGIdIkS9QFuiY0V7Saxw5lrBpsl6L7mVfx3bRXjY5dzwP4fgz6FXq7U
	 RpvoPIq+1CcoiYl6Tzv2QVAmo+EVV3Vy0dM03efQwFApmW4Vy+KD2hRKoErIGKhksF
	 bsCKqvT/d1sOlAo9yJEqwHwQqRTjQH0woiQ7AJvYOiKKbJC/RtvbTmCtQXiXqCNm1d
	 ZGZC1bHRjbQzp+on2e6E6QUky5rdwSx7QwYjBs0YcKt7eqGIxCpy9xGOT2uAzcvU/F
	 c/ix7B+Whg4BQ==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c74c0edd57so87520b6e.2;
        Mon, 22 Apr 2024 12:17:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXsqKhbvKp2P49PEV4d3c0iDMjtznONmHp/CWXimHDY5jkjvkXJvdiIlXadHVvQHLFGWrLY60pgz2q8XWJSOJHF64OOiioeTrtXIU9fJNeeWav6T7eZcas12hoEQC9+xHDKIkE3YLgen0pawjg4Sc2qqyLnDDK0vrYf0c7FM9ijjhk19zkS/zcnUQsUDCv4Xx3GsMxBS4tZ6rUlB4oUKg==
X-Gm-Message-State: AOJu0Yw8vqlaurJaruMqH+BuXZGW9dMxfEJ64u6CkS95kfNLj3C+ilH4
	Q/SmZpC+5rQlc++38MrUCVev4DbH6SjrW9o7hLgaxqjgFUbkYDb/B3p+N+otWPkMt5+RIFyL/d+
	weSDbjyyF9iKdjd36h1aAhLl9/cY=
X-Google-Smtp-Source: AGHT+IHHJ9QaEiYpQj2Hs91rOTJeMn0u59rXfQOhxmRruL4EPRiSN5Poxfp89Kp24hNMmCEZhAKqnasVJk7tiQxt2jk=
X-Received: by 2002:a05:6820:e07:b0:5aa:14ff:4128 with SMTP id
 el7-20020a0568200e0700b005aa14ff4128mr11147467oob.1.1713813428277; Mon, 22
 Apr 2024 12:17:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com> <CAJZ5v0giKShCa7AaRRmhcfTshyjDKwn487-kqRr3pqVmYJ2BrA@mail.gmail.com>
In-Reply-To: <CAJZ5v0giKShCa7AaRRmhcfTshyjDKwn487-kqRr3pqVmYJ2BrA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Apr 2024 21:16:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jBXpZPUFU+XMGV9oWf8XqKY_pTwitq4sWzZsiT5J3XoA@mail.gmail.com>
Message-ID: <CAJZ5v0jBXpZPUFU+XMGV9oWf8XqKY_pTwitq4sWzZsiT5J3XoA@mail.gmail.com>
Subject: Re: [PATCH v7 00/16] ACPI/arm64: add support for virtual cpu hotplug
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-acpi@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, 
	Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Miguel Luis <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>, 
	Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linuxarm@huawei.com, justin.he@arm.com, 
	jianyong.wu@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 9:50=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Apr 18, 2024 at 3:54=E2=80=AFPM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > Whilst it is a bit quick after v6, a couple of critical issues
> > were pointed out by Russell, Salil and Rafael + one build issue
> > had been missed, so it seems sensible to make sure those conducting
> > testing or further review have access to a fixed version.
> >
> > v7:
> >   - Fix misplaced config guard that broke bisection.
> >   - Greatly simplify the condition on which we call
> >     acpi_processor_hotadd_init().
> >   - Improve teardown ordering.
>
> Thank you for the update!
>
> From a quick look, patches [01-08/16] appear to be good now, but I'll
> do a more detailed review on the following days.

Done now, I've sent comments on patches [4-5/16].

The other patches in the first half of the series LGTM.

I can't say much about the ARM64-specific part and the last patch has
been already ACKed by Thomas.

Thanks!

