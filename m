Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10090737619
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jun 2023 22:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjFTUct (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jun 2023 16:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFTUcp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jun 2023 16:32:45 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A8EF1
        for <linux-arch@vger.kernel.org>; Tue, 20 Jun 2023 13:32:45 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-763a403642cso180281185a.3
        for <linux-arch@vger.kernel.org>; Tue, 20 Jun 2023 13:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687293164; x=1689885164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sOBwXFmC0K7NYb6lxaOI7FbE7H576FmqzhPnZbh/RQ=;
        b=tOqRhJiJuYS/iM7yaX5kRR0RI5J4yS1E5ocSFLwJFozah6ojYGDYEC3KMjqrchEHWN
         V5olyJeF5sdAVGmyxtKzlPJwixv1c+gFrSleYLPVdQZtnWtBnPtfTroLHA1oHlfq6NDf
         W6illmXhd6rNa/PIUTfFh2BSrLJMD/dE4ysNwbZpOroJXz0BTpxFlvGYRjt3C+Cs4d8e
         h/9Qo+g/BCkG3gfjk50kDZi3H1Z6DIl++Vte2DrrQ80+9d2PI1Ka0jRiR54Gv/wlxsKr
         xoljDYaj9RSg+l5SiIJnchoyU6QRqVoFXyi9s7wEvojivfMFhjAf3kYVjlrLEwk3TUR0
         mmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687293164; x=1689885164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+sOBwXFmC0K7NYb6lxaOI7FbE7H576FmqzhPnZbh/RQ=;
        b=D4lJY5nOu/DA8X93+skDF25rMqrupXVHW9lr2jhdMYVCwRa+WTvx75PXLeeHIXHFt5
         rJdUj8JgLEqPvWSL5gXOggnu9Aq1E4i4H1uNCdp2D26oQ8QqwdeAS0JEoHyaT5l6eywk
         iWPclTgOF7d1XF123FY+K/uhpUN2x2aoQ38OyJCCdFr1lmJtIOdfQ8zDcwWhsADTmjKO
         Hr8Q4bV4/JdjSnX6uhtYlnozWGht8E45pB+s4nTSW+seTzqrxPPfivA6zWtM30bn3eB/
         MRiBNLTlniuHK6XwEyXUy2uRZthUlFR+UV/hFmrqaCxcuTzS6IJXUCYBwdzES5D43rwM
         P/VQ==
X-Gm-Message-State: AC+VfDyGbIoj7h1U64UD/9y7SIgyQtVxSQxFdX9/4JO8H/KCx98JFTqP
        n/OHTSzp/h6+9TvkaxE42P+7hWS9SFQg/IX7+jwFuw==
X-Google-Smtp-Source: ACHHUZ6EhOw5QjdhJDMDyaak9jtIy0YjhsLT4zH/jrMO4dPXvi62mXQ76XWruSIP2mh7WnNIEl42KmnbfYo3WvG4pQQ=
X-Received: by 2002:a05:6214:e4f:b0:62d:fd45:4d6a with SMTP id
 o15-20020a0562140e4f00b0062dfd454d6amr16222761qvc.16.1687293164010; Tue, 20
 Jun 2023 13:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-41a06775-95dc-4747-aaab-2c5c83fd6422@palmer-ri-x1c9>
 <mhng-57559277-afaa-4a85-a3ad-b9be6dba737f@palmer-ri-x1c9>
 <CAKwvOdmsgMN5oQpDLh12D0X-CfQDtHC-EtxHcBnADkhnyitMKQ@mail.gmail.com> <20230620-gibberish-unblended-f4b50c7fe369@spud>
In-Reply-To: <20230620-gibberish-unblended-f4b50c7fe369@spud>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 20 Jun 2023 16:32:32 -0400
Message-ID: <CAKwvOdn_U+yjFBn6pq5XwP1rTEKA1MWBkd0f2N8wB_nuS1_sWw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, jszhang@kernel.org,
        llvm@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Fangrui Song <maskray@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 20, 2023 at 4:13=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Tue, Jun 20, 2023 at 04:05:55PM -0400, Nick Desaulniers wrote:
> > On Mon, Jun 19, 2023 at 6:06=E2=80=AFPM Palmer Dabbelt <palmer@dabbelt.=
com> wrote:
> > > On Thu, 15 Jun 2023 06:54:33 PDT (-0700), Palmer Dabbelt wrote:
> > > > On Wed, 14 Jun 2023 09:25:49 PDT (-0700), jszhang@kernel.org wrote:
> > > >> On Wed, Jun 14, 2023 at 07:49:17AM -0700, Palmer Dabbelt wrote:
> > > >>> On Tue, 23 May 2023 09:54:58 PDT (-0700), jszhang@kernel.org wrot=
e:
>
> > > >> Commit 3b90b09af5be ("riscv: Fix orphan section warnings caused by
> > > >> kernel/pi") touches vmlinux.lds.S, so to make the merge easy, this
> > > >> series is based on 6.4-rc2.
> > > >
> > > > Thanks.
> > >
> > > Sorry to be so slow here, but I think this is causing LLD to hang on
> > > allmodconfig.  I'm still getting to the bottom of it, there's a few
> > > other things I have in flight still.
> >
> > Confirmed with v3 on mainline (linux-next is pretty red at the moment).
> > https://lore.kernel.org/linux-riscv/20230517082936.37563-1-falcon@tinyl=
ab.org/
>
> Just FYI Nick, there's been some concurrent work here from different
> people working on the same thing & the v3 you linked (from Zhangjin) was
> superseded by this v2 (from Jisheng).

Ah! I've been testing the deprecated patch set, sorry I just looked on
lore for "dead code" on riscv-linux and grabbed the first thread,
without noticing the difference in authors or new version numbers for
distinct series. ok, nevermind my noise.  I'll follow up with the
correct patch set, sorry!

>
> Cheers,
> Conor.



--=20
Thanks,
~Nick Desaulniers
