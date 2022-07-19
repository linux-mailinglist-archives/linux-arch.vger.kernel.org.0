Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE05657947A
	for <lists+linux-arch@lfdr.de>; Tue, 19 Jul 2022 09:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbiGSHqW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jul 2022 03:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiGSHqU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jul 2022 03:46:20 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9CF22532;
        Tue, 19 Jul 2022 00:46:18 -0700 (PDT)
Received: from mail-yw1-f180.google.com ([209.85.128.180]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mg6i8-1napXy1zRe-00hiJM; Tue, 19 Jul 2022 09:46:16 +0200
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-31dfe25bd49so94755227b3.2;
        Tue, 19 Jul 2022 00:46:15 -0700 (PDT)
X-Gm-Message-State: AJIora9xv1V6445pTlUMk3XevKq+sssi4rBtfZ5xUI19oFcCyBlG5LwA
        ok/pgLbdjDKVyjLmVdS8kLyaiMYNI95J3y2VLXM=
X-Google-Smtp-Source: AGRyM1uMUiVIGFjzA5TwWJRveS7h+exlQBS7bP6K2zksjYwuZuF4ih7u9nFVzpOHSizyHdxkqT+sJR2F1c3sqVPvIcs=
X-Received: by 2002:a81:1914:0:b0:31c:e12a:f33a with SMTP id
 20-20020a811914000000b0031ce12af33amr34887188ywz.209.1658216774978; Tue, 19
 Jul 2022 00:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220717033453.2896843-1-shorne@gmail.com> <20220717033453.2896843-3-shorne@gmail.com>
 <YtTjeEnKr8f8z4JS@infradead.org> <CAK8P3a1KJe4K5g1z-Faoxc9NhXqjCUWxnvk2HPxsj2wzG_iDbg@mail.gmail.com>
 <CAAfxs740yz1vJmtFHOPTXT6fqi0+37SR_OhoGsONe4mx_21+_g@mail.gmail.com>
In-Reply-To: <CAAfxs740yz1vJmtFHOPTXT6fqi0+37SR_OhoGsONe4mx_21+_g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Jul 2022 09:45:58 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1Mo9+-t21rkP8SDnPrmbj3-uuVPtmHbeUerAevxN3TNw@mail.gmail.com>
Message-ID: <CAK8P3a1Mo9+-t21rkP8SDnPrmbj3-uuVPtmHbeUerAevxN3TNw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] asm-generic: Add new pci.h and use it
To:     Stafford Horne <shorne@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:6Wsbwu5+/Md0neanrtNmqGmxxhxkKwehWq/5AFSS6561YGKDWOK
 4yVOQr1uiPyk1OHWow5WyiqTvdgIK9bNlys0oZYmNPMc1Rly77q7t2qYUjOqpfqvZ7zodfe
 PUq4E21derg05mubU0FVuW4Zmi+H5cz5qKJue1BELa8Abt2Z5OAt9cF/Mfmx4I7SjskMvXL
 YSMWCTYchqAdUmFydJW/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M3/Ty2MYcKw=:c8NLiwITQfbvzv1FCRulYV
 oQLMLSCrI5sQ4Z679DdOtXgYLTkCAHJejxlX34vfPmXZQTdWoIDwGYKYJq710r5usU3G8pwOo
 KjM0+zZzwQImCBzOinuPaCuhTybjmTOPcF+TE/0L4qgp55LEbKiQtPkmR1WOhssXpPueKEtsB
 C3xcLdGp29jaGrkxyJBaeOr63GN6UlZCfpG/fiylkdNJh4UZr3rWBh+9BeGNuXtVRVaFMLcla
 YpFkvD/9gS11xfOcgSrYHtoDZzDKhIiWlVn9buQzqfvSnypwK84DFN1y2FLsDiprVkWRs2gEH
 bgaNVVW2Pax0M8uJegUh9Mk1WpoyttJUeWHXP7qYx6HMqr8Z5hUbTXZM4A6a25hb3kozK2rM2
 W4beARS5KzBV9WvBxAQxzYLCW2+xWabxZI1tWbFuZzc4sVYQ3l3NwelqhFCsosPQE/2zKrguN
 V0L7CNgc471nHFZLeV0M+c4ZOvHuV0MpiRlKJZ3tIYujmxkF0A26OBMixhR7yjHeJJFw3KLsR
 g5yncPe89L4lDvvIa68HK9+Wmg5R4g5jLA9wOT3iuPvE5jHHdaJx/FX1lRcGMoyFzbDQr1nOl
 RmaR+gLo3zhbWIZkqEbFo4MaaAMrOBauWaEpBZPEeNtVDPjRRhLGPDVAlRGhhn/5TvWq40UOD
 S+8wbv06+6S+kDZvz6euq6T8CkhWgMLqm1gauv8unWFFWjmLi7E0J+W0RWS48TjK+FcOdNe2j
 xoblL9+s8p6MLjuePejwzEi/kj7GHZMxWkHK4Lx89FMs/USETjWKE+RTaYDdQ4i//it03j4LB
 ZmnEMO6PJ63PJaIL4QvR5WPk8h/PQXjeKE8Iu5HTc07a1MHKdnQhh/6nhRhafi1UgxfjHtw69
 1boV4xNM3HG+Vll82jCQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 19, 2022 at 1:19 AM Stafford Horne <shorne@gmail.com> wrote:
> On Mon, Jul 18, 2022, 3:56 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> As mentioned before, it would be even better to just remove it
>> entirely from everything except x86, and enclose the four
>> references in an explicit "#ifdef X86_32". The variable declaration
>> only exists because drivers/pci/quirks.c is compiled on all
>> architecture, but the individual quirk is only active  based on
>> the PCI device ID of certain early PCI-ISA bridges.
>
>
> Ok, I was thinking of that route but once I saw the pci device IDs I
> wasn't so sure it was limited to x86.  I'll go ahead with that approach.

Ok, thanks!

I checked all the PCI IDs yesterday, and I'm fairly sure they are x86
specific. While some related products are general-purpose PCI-ISA
bridges that have shown up on mips or arm boards, the ones listed
here should all be safe.

         Arnd
