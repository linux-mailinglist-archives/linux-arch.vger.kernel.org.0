Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3862CE599
	for <lists+linux-arch@lfdr.de>; Fri,  4 Dec 2020 03:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgLDCSm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Dec 2020 21:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgLDCSm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Dec 2020 21:18:42 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71811C061A4F
        for <linux-arch@vger.kernel.org>; Thu,  3 Dec 2020 18:18:02 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id o4so2613981pgj.0
        for <linux-arch@vger.kernel.org>; Thu, 03 Dec 2020 18:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Fd2ivA1JfGBE/YYaFxTeQJoY+3hIQ82HTGN9ThwBn8w=;
        b=bd67G5cfWvkCpWSjpFtI1+6l2zRYD23xLf/mhlvIDACjrdi9nyf9dA0r6nvvREyg08
         f3/zsofCKY9aHt8SOxoMx94nNle0IBiOTvBwYKGdD9BVOEcCdLCVu0I6aOeaq7weUEWd
         EEIsrpT29dZ7HUU6IaIcUu+7qyqHljF6kf1ZearRQIWy4NWCn0VtkvVswIJqSbx1kOPr
         WLin59SvycwQtsrRgOoTfDikupSHB/+1QbEuAminucunl/PpeQO2nhXPBX/ZUzrub1eG
         EpYVkC2O08NhLbUm2XXwT50LKLrJr4vr8BkrzMgNmwHT5STBd5lQTFYdQbdw0F0SfX1w
         5njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Fd2ivA1JfGBE/YYaFxTeQJoY+3hIQ82HTGN9ThwBn8w=;
        b=WBj4VuWXQviTPyrU6Tp/OgqTnyI3i2TFb+rBwvJTJS9jV5xxbXV4UGNzPqFA0StokI
         liw+mkCjmvU9G2B6rvpQOTCX+i2bQzI0bbYPdEa8vxfQ3ViAfyBYPFxqSJGfmmjXeSJh
         R0gDdLL4cfSg5gA5kdteRsgtBI3kbEgNVxdWxfX8CfGTtCzlswLFW79fdSRBtmMysWY+
         axvHjQgpezgFkGRPcb9fmaJXp0/A/Hxe9+2emN/TQ0/QCGSPPq5rh5F1saoLynGiJbCE
         TryamLgP+GYA3DDpPhPQOskJB894RT8yLqRH9jnALC85RQtqg8vWBEmBaQ2W00DfC5Nh
         NzRw==
X-Gm-Message-State: AOAM5334C2xXhLWN+DndzTr+9FntEaAVW9Q5CyJcarR5sZmMZH/Cu54T
        EG5KE+Kovoc9wJ9DZFhHc6AXAg==
X-Google-Smtp-Source: ABdhPJyNuKKB+iExcQqlDxHUMCskHI2/BePAL+9W0Ez0GHtzU2CIr3B8j01gRJIOeumT/wnwKHF+4w==
X-Received: by 2002:a63:f64c:: with SMTP id u12mr5577532pgj.325.1607048281788;
        Thu, 03 Dec 2020 18:18:01 -0800 (PST)
Received: from ?IPv6:2600:1010:b052:49bb:5861:3d22:1fe4:dfb5? ([2600:1010:b052:49bb:5861:3d22:1fe4:dfb5])
        by smtp.gmail.com with ESMTPSA id v17sm2249260pga.58.2020.12.03.18.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 18:18:01 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [MOCKUP] x86/mm: Lightweight lazy mm refcounting
Date:   Thu, 3 Dec 2020 18:17:59 -0800
Message-Id: <3B47C470-2900-4A53-9F8E-CB3A003FA361@amacapital.net>
References: <1607033145.hcppy9ndl4.astroid@bobo.none>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Rik van Riel <riel@surriel.com>,
        Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>
In-Reply-To: <1607033145.hcppy9ndl4.astroid@bobo.none>
To:     Nicholas Piggin <npiggin@gmail.com>
X-Mailer: iPhone Mail (18B121)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> On Dec 3, 2020, at 2:13 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
>=20
> =EF=BB=BFExcerpts from Peter Zijlstra's message of December 3, 2020 6:44 p=
m:
>>> On Wed, Dec 02, 2020 at 09:25:51PM -0800, Andy Lutomirski wrote:
>>>=20
>>> power: same as ARM, except that the loop may be rather larger since
>>> the systems are bigger.  But I imagine it's still faster than Nick's
>>> approach -- a cmpxchg to a remote cacheline should still be faster than
>>> an IPI shootdown.=20
>>=20
>> While a single atomic might be cheaper than an IPI, the comparison
>> doesn't work out nicely. You do the xchg() on every unlazy, while the
>> IPI would be once per process exit.
>>=20
>> So over the life of the process, it might do very many unlazies, adding
>> up to a total cost far in excess of what the single IPI would've been.
>=20
> Yeah this is the concern, I looked at things that add cost to the
> idle switch code and it gets hard to justify the scalability improvement
> when you slow these fundmaental things down even a bit.

v2 fixes this and is generally much nicer. I=E2=80=99ll send it out in a cou=
ple hours.

>=20
> I still think working on the assumption that IPIs =3D scary expensive=20
> might not be correct. An IPI itself is, but you only issue them when=20
> you've left a lazy mm on another CPU which just isn't that often.
>=20
> Thanks,
> Nick
