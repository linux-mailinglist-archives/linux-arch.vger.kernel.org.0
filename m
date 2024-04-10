Return-Path: <linux-arch+bounces-3547-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7888A0056
	for <lists+linux-arch@lfdr.de>; Wed, 10 Apr 2024 21:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A1E3285BBF
	for <lists+linux-arch@lfdr.de>; Wed, 10 Apr 2024 19:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE997180A87;
	Wed, 10 Apr 2024 19:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBer6g/F"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA1A180A86;
	Wed, 10 Apr 2024 19:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712776099; cv=none; b=EtzrVovDPJtb3RcgD8shBseajdok2aUCNxOv/QJ5b3vg+oefJKWW2PUxlcm6Ekz3d8ZIjRl5p5HVNlnvaFqMMfa3oS5D0tkZmmRQRCS+wPuCCHHdLpRREtgLvC9B8EJH9RVUOmDHpCPmBjeeHmJ3kNPnJUvFwfMml+Ao5H0GEww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712776099; c=relaxed/simple;
	bh=+eWLmlEP0bVT8/CZ2rvIUuWI74CBRr7mdsinkobDlzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s0zAlb3obPdyyh6dEX0A0aj6cuu2F96psUrSjwzaXMHD56hbfgOJoBMD0S+bFRVwRym4rzZpntr0U554uCW6OuLeYbuLnHsF7SFDfRixwnsMmGTXeqVL12Qpg5AzJ/6vU2159QnWKOhNeORCUX46+7VBozzodqFRoEXAu7RPl90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBer6g/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5822DC43399;
	Wed, 10 Apr 2024 19:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712776099;
	bh=+eWLmlEP0bVT8/CZ2rvIUuWI74CBRr7mdsinkobDlzU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kBer6g/FSVcQNlQN/dT52LUBGg0hkyFCcgbXq3fUnv4hC2VilA1zuyGqPVGaoI9rz
	 0/MBcRSiQDjk5VbvTar8s1MII5Y0adKzNxjkxeYxriw3mc+K55GlJawuRxte3IPF3T
	 0yjLhDefgapwQ1FYh/ibQke8EUvsYSFf2Bt7tSkMULO3L6dgzwxMmS2ZrG0XpBh0qj
	 TZ6p5zrmOCPyTsntakq4I6xUnUrHcUgIY7EjynOD9Edj3qR4Uj1GT2QnyWxaffty1+
	 T4vEkU9e25UakyTkLUOKd2E5zgMj5xwEQfwgEcWbJ/DWijYATCohmlmkXXuvdqLrVa
	 rpMLs6ScIMD8Q==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-22ed9094168so486564fac.1;
        Wed, 10 Apr 2024 12:08:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVWjVtMwazDm0dYOZs7vaOMDj9FKux0jbkncjrD7balQURhAj1QAH3eEJEW4qWGJKK+qv5rYjWUTXtwtGnrwg0ukJquinUond1XfrKrvTA8o/LQHZF+uiUtqvvVDDfP7GKDMH5PZOf9I4dl/z5ZgCAIpaNuIwJ4Jcq2uJDuOCw80aGurdMWPUkmzcTeASv2JqxzOeEIwxJoQrtx5AXPrp0cvjX5J9XbRhkC9p6j0pv//LNsNK3GIDSqrGQX/m4vMwVszdwM3odXH2SL70vhGGU8b/Yo263isdiiKwVUBqS+7xwUu+Y6aW6j54H8kjM3H14lTB33kSLKu1KYwDIGGlkVaR9SWOPGR29/+aF5s+jR
X-Gm-Message-State: AOJu0YwiuMw0E8ttSoY0iBgn9jyWMrwX8Ru1e5gfcOqDgsuCuCY6wbqV
	93O+j6PTmqPyP0PMhf9lui1HB1uCCppeWfWsMC6vyfuAzf22t9bvD9NpFJTvL2C4gWi4IMq4ir6
	ret42w9IjLOSPH57cUCIZtv4fRY4=
X-Google-Smtp-Source: AGHT+IH4A92J5HCRnizSgBq3+DCMERDHMutgLTgDu/kxW+WK07c2IT8FOUNC46ZvoIhnKLsY7Mrt28XT6qdFy5OJWR8=
X-Received: by 2002:a05:6870:219d:b0:22e:b2ea:5758 with SMTP id
 l29-20020a056870219d00b0022eb2ea5758mr3756127oae.0.1712776098584; Wed, 10 Apr
 2024 12:08:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk> <E1rVDmU-0027YP-Jz@rmk-PC.armlinux.org.uk>
 <CAJZ5v0iiJpUWq5GMSnKFWQTzn_bdwoQz9m=hDaXNg4Lj_ePF4g@mail.gmail.com>
 <20240322185327.00002416@Huawei.com> <20240410134318.0000193c@huawei.com>
 <CAJZ5v0ggD042sfz3jDXQVDUxQZu_AWaF2ox-Me8CvFeRB8nczw@mail.gmail.com>
 <20240410145005.00003050@Huawei.com> <ZhbgwBBvh6ccdO7x@shell.armlinux.org.uk>
In-Reply-To: <ZhbgwBBvh6ccdO7x@shell.armlinux.org.uk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Apr 2024 21:08:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gG0xLajHsWXVM+-V+fQZAudvojechUa-DzFgwCs2q8Dg@mail.gmail.com>
Message-ID: <CAJZ5v0gG0xLajHsWXVM+-V+fQZAudvojechUa-DzFgwCs2q8Dg@mail.gmail.com>
Subject: Re: [PATCH RFC v4 02/15] ACPI: processor: Register all CPUs from acpi_processor_get_info()
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-pm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, 
	acpica-devel@lists.linuxfoundation.org, linux-csky@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org, 
	linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com, justin.he@arm.com, 
	James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 8:56=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Wed, Apr 10, 2024 at 02:50:05PM +0100, Jonathan Cameron wrote:
> > If we get rid of this catch all, solution would be to move the
> > !acpi_disabled check into the arm64 version of arch_cpu_register()
> > because we would only want the delayed registration path to be
> > used on ACPI cases where the question of CPU availability can't
> > yet be resolved.
>
> Aren't we then needing two arch_register_cpu() implementations?
> I'm assuming that you're suggesting that the !acpi_disabled, then
> do nothing check is moved into arch_register_cpu() - or to put it
> another way, arch_register_cpu() does nothing if ACPI is enabled.
>
> If arch_register_cpu() does nothing if ACPI is enabled, how do
> CPUs get registered (and sysfs files get created to control them)
> on ACPI systems? ACPI wouldn't be able to call arch_register_cpu(),
> so I suspect you'll need an ACPI-specific version of this function.

arch_register_cpu() will do what it does, but it will check (upfront)
if ACPI is enabled and if so, if the ACPI Namespace is available.  In
the case when ACPI is enabled and the ACPI Namespace is not ready, it
will return -EPROBE_DEFER (say).

