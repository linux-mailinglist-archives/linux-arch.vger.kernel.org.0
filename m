Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD641EE1CE
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jun 2020 11:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgFDJu0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Jun 2020 05:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbgFDJu0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Jun 2020 05:50:26 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7312C08C5C2
        for <linux-arch@vger.kernel.org>; Thu,  4 Jun 2020 02:50:25 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q8so5308781qkm.12
        for <linux-arch@vger.kernel.org>; Thu, 04 Jun 2020 02:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Kg6vPoyo+bqnNzeJ15v0h+k7UDJ+CL28zwznimZSCUE=;
        b=iTjBd5guz5HISGo2ssTQ3kdQtGEPcHruUrD+LnAE3oz6ejT5z7/X/1k6Lyhf8TKx5b
         ochOdOSIBb3h3Y16Pi6ii3tWoOJc7cfmg89ims3xh6+Jh8IhCFODcDigvdJUGn8PoFjT
         EkTUAsSp67YsNdsVwVT1r5Vu+evKW2mO3OAUqZvAKH38vSPvlDik/Uz5OVTy8vUxXLlw
         M32Z0qFp1SSOkv3GtQlbFiN4KDNE4Nike0Je9+qrq8Pcg7mXbqKBqHyIM6FNfuqeEz2s
         6n7X6JWYsNnBUTnlr9W/I3IY3mmtryZOuLjZUJqh6MakrvWInHU4vUrvtFma0HR0YPjH
         DA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Kg6vPoyo+bqnNzeJ15v0h+k7UDJ+CL28zwznimZSCUE=;
        b=XcuFT04iOsmDkJWESoJeTphPDUN+C+SbFNc34oPYtjGADiIa2BJk70b63julo7jh0m
         W0f/ToAJ4r41/53sjasVV5fkPYpPCrhWB8NC/dI2tGzmdfNDUBi16JgGytCvKqc6lVj/
         h9mnD3+Z4u8ADRz+6eIDhhtVN6AVmPLVc4bchl0MPIGbd9fmkOSvOLU8A45k0azvFnV3
         pwLzVunI/RxbMF+/6RtSuE4v707ZfZdb/HMQuBK3qttSZ/ibP5Kw/sL3h4mCGXesM6DS
         7WdV1/PBgBTBNWYkWC6OmtgV9SDZnSi5smbW/n2IzddsHSygiQQGnI0SaozKOhYSMHCs
         DDgA==
X-Gm-Message-State: AOAM5332afTHKfLM84SzY3kWNWkLBgtsIfrx2Fs5iVzc5kVFs/W/DbhB
        /6A9mDFhVl8h2Mfp85CPq4mQog==
X-Google-Smtp-Source: ABdhPJxfD/CO+vni4AqlLMUrdeQZhzI4lfqDbPL9gDbqoVSPBGPQonJSf2x+4N4xRGOEhDNSqWev4g==
X-Received: by 2002:a05:620a:1218:: with SMTP id u24mr3544315qkj.422.1591264224746;
        Thu, 04 Jun 2020 02:50:24 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id k20sm4369904qtu.16.2020.06.04.02.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 02:50:23 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 08/14] powerpc: add support for folded p4d page tables
Date:   Thu, 4 Jun 2020 05:50:23 -0400
Message-Id: <F85B8F19-D717-411A-AFA8-466A02159F27@lca.pw>
References: <20200603120522.7646d56a23088416a7d3fc1a@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brian Cain <bcain@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guan Xuetao <gxt@pku.edu.cn>,
        James Morse <James.Morse@arm.com>,
        Jonas Bonn <jonas@southpole.se>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        kvmarm@lists.cs.columbia.edu, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        Mike Rapoport <rppt@linux.ibm.com>
In-Reply-To: <20200603120522.7646d56a23088416a7d3fc1a@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: iPhone Mail (17F80)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Jun 3, 2020, at 3:05 PM, Andrew Morton <akpm@linux-foundation.org> wrot=
e:
>=20
> A bunch of new material just landed in linux-next/powerpc.
>=20
> The timing is awkward!  I trust this will be going into mainline during
> this merge window?  If not, please drop it and repull after -rc1.

I have noticed the same pattern over and over again, i.e., many powerpc new m=
aterial has only shown up in linux-next for only a few days before sending f=
or a pull request to Linus.

There are absolutely no safe net for this kind of practice. The main problem=
 is that Linus seems totally fine with it.=
