Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E423C68B45D
	for <lists+linux-arch@lfdr.de>; Mon,  6 Feb 2023 04:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjBFDKd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Feb 2023 22:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBFDKc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Feb 2023 22:10:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DD91A941;
        Sun,  5 Feb 2023 19:10:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C923B80956;
        Mon,  6 Feb 2023 03:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE494C4339E;
        Mon,  6 Feb 2023 03:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675653026;
        bh=nqhet8AEH/ERw6EgCSei5hYnW8DmeRHxsYNumUSvwbY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Djrdlt17tFAs5kmQ+hq2mmen6079HT9RIn+DVBPGhaKD2U4E9s+l8LnlkBCnWPMnf
         VMQ4nyV5WLWGr6S2SdjOvyJhNFb0hdBYeyZxEjqAteA70KsleXKjcU2GgyVaS83+7q
         PiaixkvbVNpcEbIeQ1luetuniK0Ji5D4gZYfMeZeRponPvL5eM5Zsm6zOWrVyQNvcf
         utaYB0C8DWpbnE0yalhhOtDSExEzvWHQTQ1QXFs6GR40Qo+vDx7SBAojCZi30aaZdn
         wkstLxVYLQ/0xACODjamM9e8fjLIZhDGrKzkEf0QFMiKiZ/5JvI2XArlwK3XwT35We
         NTe5ddkcOuYfA==
Received: by mail-ej1-f50.google.com with SMTP id ud5so30501231ejc.4;
        Sun, 05 Feb 2023 19:10:25 -0800 (PST)
X-Gm-Message-State: AO0yUKU+xG8gYreJSajFxr3n0vGiw1gGS5eJ9FEUCKzvl0ibGjHSGutX
        DGF/rBOlLADDZd9/37c5PY2RRye3VS/KOQ7/PHE=
X-Google-Smtp-Source: AK7set/MwuNHj3cEDBq/n80X1OTFxhSGWKa4ldcgofmG5jw+SyQf1PSEiXQXk+siHZwTVsRqsSrlncJkMA1Ypzks4JM=
X-Received: by 2002:a17:906:8419:b0:884:c19c:7c6 with SMTP id
 n25-20020a170906841900b00884c19c07c6mr4723974ejx.120.1675653024117; Sun, 05
 Feb 2023 19:10:24 -0800 (PST)
MIME-Version: 1.0
References: <20230201064608.3486136-1-guoren@kernel.org> <87tu05pvur.fsf@all.your.base.are.belong.to.us>
 <CAJF2gTSj12E9+peMF0rNY_psGDyEG5BbMY6V-s4dK0FpkCC9Yw@mail.gmail.com>
 <87cz6s75ze.fsf@all.your.base.are.belong.to.us> <5C373F4A-983E-4ACA-AAB0-54E629D5F501@jrtc27.com>
 <878rhgrv6a.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <878rhgrv6a.fsf@all.your.base.are.belong.to.us>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 6 Feb 2023 11:10:12 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTuva2HmoJymP1atfKxudS67XY8pygukgEH98D=o3dwUw@mail.gmail.com>
Message-ID: <CAJF2gTTuva2HmoJymP1atfKxudS67XY8pygukgEH98D=o3dwUw@mail.gmail.com>
Subject: Re: [PATCH] riscv: kprobe: Fixup misaligned load text
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        liaochang1@huawei.com, linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Bjorn Topel <bjorn.topel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 2, 2023 at 10:36 PM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wr=
ote:
>
> Jessica Clarke <jrtc27@jrtc27.com> writes:
>
> >> +    p->opcode =3D *insn++;
> >> +    if (GET_INSN_LENGTH(p->opcode) =3D=3D 4)
> >> +            p->opcode |=3D *insn << 16;
> >
> > *insn gets promoted to int not unsigned so this is UB if bit 15 is set.
>
> Ugh. Good catch! I guess we can't get rid of *that* explicit cast to
> kprobe_opcode_t here...
Hi Bjorn & Jessica,
Thx for reviewing.

The new version came out:
https://lore.kernel.org/linux-riscv/20230204063531.740220-1-guoren@kernel.o=
rg/





--
Best Regards
 Guo Ren
