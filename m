Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82ABF52BC26
	for <lists+linux-arch@lfdr.de>; Wed, 18 May 2022 16:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238056AbiERNmO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 May 2022 09:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238051AbiERNmN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 May 2022 09:42:13 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EF419C754;
        Wed, 18 May 2022 06:42:11 -0700 (PDT)
Received: from mail-yb1-f171.google.com ([209.85.219.171]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MV6G0-1oH3kl3tqA-00S6Df; Wed, 18 May 2022 15:42:10 +0200
Received: by mail-yb1-f171.google.com with SMTP id r1so3710132ybo.7;
        Wed, 18 May 2022 06:42:09 -0700 (PDT)
X-Gm-Message-State: AOAM532mwljm7QhGog1Ozi2+BC37XdWVkLs5vEXCzi1oFCrLmllXo2TN
        87jkvsRRnMe0jZ1FHCJ/tDYd9qrHc4Z0eH+0cJ0=
X-Google-Smtp-Source: ABdhPJwF48jLhG/+AfxWmCnEeiKLqJ8UZuTJC+Pw8l97uOFrR22mgsXO3Z5XrirQNf54YIn4ndeQ8Y4a8mWoYzhJzfI=
X-Received: by 2002:a25:d607:0:b0:64d:bbc4:5bcf with SMTP id
 n7-20020a25d607000000b0064dbbc45bcfmr12694971ybg.550.1652881328511; Wed, 18
 May 2022 06:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220518092619.1269111-1-chenhuacai@loongson.cn>
In-Reply-To: <20220518092619.1269111-1-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 18 May 2022 14:42:07 +0100
X-Gmail-Original-Message-ID: <CAK8P3a15oQNZvST56v0AvtC1oZP4iDHy-QMLwZuDAg30gq-+4A@mail.gmail.com>
Message-ID: <CAK8P3a15oQNZvST56v0AvtC1oZP4iDHy-QMLwZuDAg30gq-+4A@mail.gmail.com>
Subject: Re: [PATCH V11 00/22] arch: Add basic LoongArch support
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:yzzh/Bvedw1+TODKA9j8JOP/sQBxZOile5/C/Y0YZ0ViizDVn7H
 zIG0Sd5N8Lr15LiqqD3BZ4Gdyt1YyLT1K5z4cL6mEyhk1lwr6pF5m3Jp90wh++A7/RIHL/O
 ej1eIS6oKS6RrgSIsbqU6/hzNn571shxP+Uj7SS41s1hwwF6+zsU14xkhPmkIJCr9pnU7Pj
 4315fH2NSeIVl6UkSAe7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ar4lpxslaLs=:HH5jRpRN0EVqYyceucHww2
 p1zaqKDdMxBZHsI/knQfqdYOzYC9b/6nVQrIJBsauYsog9/IDLloPVCu41/rgF/F/x69D9X3Z
 m3RIFfRHohDpRaKKkvgxZlegarYzWZbm2e1N2JJ+SdzVXIMMfi1zFAgnEGHlHNOPXeV3TFdQV
 O0KwFcRhDIOwacMgmic5KEBxxDUwiPNS21UJR7/U+UUXwT1yi1FrvFQY0KSOGEEiBkEQoGwRF
 CBgizukNFiCCDeA2T9Vj5IF6S+Os/moTWcFGY5J6ghmaHJSBAE6NhUFzjx9XUzZjp84UG9Gvf
 AiX+S0x/z2JW/pjTIChjm9G7uygw6fiV9N6kQDX4ndWXuKe1PPsfxqZEz0FNM0IsNf8alTaSZ
 PE7YHZERKzY4i4n7dPNT2WqdrlE90CHkDTiCtwcZVVoCO86tVuHtfkNnEHdM0O61ZsOjBFTh1
 xubkVQXU5bkgfXfml+HfAppw4mt0OKSRRsmYtzTZ2grgugaHWxZDjt+wtjo+VTfG2HfEzCC/K
 NQHpFr+DjxNYG5FJG8zIVVxpkD9EnW5vYngaheUp0HNO2bVi3c3lTeemgnLfD0kd1yx0ZSSiY
 QKW876zQFJBsA9BACXdzSGmBso2myWCuk6QEk94IroWkXdlQpCnBepMY873hFQwtfV1dlWzhp
 k+HjuIr2xvphdxFZdMooQRAuvksGEhsyLjUPKNOn3Xynh9xx+FBso4xlE7h/uqz7rm8P8cRFk
 fYg9A5ImS59uUweTeqcfbWbM+6MojKfzzZbbzmJsBM2QgKQaSy9Lr9DxLxF1BwaRK9iX6rdJa
 5oJh1C83vrdPCg3nBy4UedJG3GB+GXSSp9B6m7n7s3sy86quw/7dEGFEgG3BU8GyeUA1j2urU
 gMlKVBDe7E+Bax8ku7iw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 18, 2022 at 10:25 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
> LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit
> version (LA32S) and a 64-bit version (LA64). LoongArch use ACPI as its
> boot protocol LoongArch-specific interrupt controllers (similar to APIC)
> are already added in the next revision of ACPI Specification (current
> revision is 6.4).
>
> This patchset is adding basic LoongArch support in mainline kernel, we
> can see a complete snapshot here:
> https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/log/?h=loongarch-next

Stephen, can you add this branch to the linux-next tree?

I see there are still comments coming in, but at some point this has
to just be considered good enough that any further changes can be addressed
with patches on top rather than rebasing.

> V10 -> V11:
> 1, Rebased on asm-generic tree;

I was expecting that you'd base this on just the spinlock changes from Palmer's
tree that are part of the asm-generic tree rather than all of what I have.

Can you rebase it once more? If there are conflicts against the h8300 removal
series that is also in asm-generic, leaving it on top of that may be
easier though.

        Arnd
