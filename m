Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07D84C6B4C
	for <lists+linux-arch@lfdr.de>; Mon, 28 Feb 2022 12:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbiB1Lww (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 06:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbiB1Lwp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 06:52:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0C0723FA;
        Mon, 28 Feb 2022 03:52:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FA84610A5;
        Mon, 28 Feb 2022 11:52:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D047DC340F4;
        Mon, 28 Feb 2022 11:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646049124;
        bh=12lEy+rZsxAbLHQ5lt0XyIX0neTrZHPLb7NInfEDMcc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SRUpKzRNM4/KvOrKZXX7WF2i3gFVTE8eW4pQGcpOQY9lp11YUOi3PxFsqPQvayCcd
         RRo+6AjFr6sHDBYCIzu8qorItwxwkpV7cFz/6ed3WeK85FWLoO8LE0n9BtEWjwLeO7
         yd+DcrFdwcNtDn6FwQVrJ7BaW3zCEq92ftdj5pmrtHJ813v/tA01YhvNqsz2dEniAl
         PH5k3aV7bSLqvavFPxscXymknzz0TGMzguJvKQDvpHWq+ZACEGv7AuOLT0qp0VrJEy
         9TBxwBhu4oGQTJJvVShyBZtx59FEQhySIYwjZqDbIgoeORdOgeWKvtRlJ0da7lM122
         gBTYswmMcsFBw==
Received: by mail-vs1-f43.google.com with SMTP id t22so12649269vsa.4;
        Mon, 28 Feb 2022 03:52:04 -0800 (PST)
X-Gm-Message-State: AOAM530VDjlDabPibvx6yfj4ZQBcUp3L2Qv3P3oKV8IqN9Efk8Vf3AEK
        SM9bh9TFh1of601oH8oygNHEdOC6AmkcWGxfycM=
X-Google-Smtp-Source: ABdhPJyyPh+wlne6x5ff7JCJYWjx6kud3nRui6/1lnG2gpd2T7gIweR6o3nUA+PM6jttzlFNCgpAgO9PQ0gdkcBMjWc=
X-Received: by 2002:a05:6102:c4a:b0:31a:54e6:edb1 with SMTP id
 y10-20020a0561020c4a00b0031a54e6edb1mr6626535vss.51.1646049123736; Mon, 28
 Feb 2022 03:52:03 -0800 (PST)
MIME-Version: 1.0
References: <20220227162831.674483-1-guoren@kernel.org> <20220227162831.674483-4-guoren@kernel.org>
 <b8e765910e274c0fb574ff23f88b881c@AcuMS.aculab.com>
In-Reply-To: <b8e765910e274c0fb574ff23f88b881c@AcuMS.aculab.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 28 Feb 2022 19:51:52 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRQ0XWSjoEeREtEGr5PPD-rHrBKFY_i6_9uW3eEN_6muQ@mail.gmail.com>
Message-ID: <CAJF2gTRQ0XWSjoEeREtEGr5PPD-rHrBKFY_i6_9uW3eEN_6muQ@mail.gmail.com>
Subject: Re: [PATCH V7 03/20] compat: consolidate the compat_flock{,64} definition
To:     David Laight <David.Laight@aculab.com>
Cc:     "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "liush@allwinnertech.com" <liush@allwinnertech.com>,
        "wefu@redhat.com" <wefu@redhat.com>,
        "drew@beagleboard.org" <drew@beagleboard.org>,
        "wangjunqiang@iscas.ac.cn" <wangjunqiang@iscas.ac.cn>,
        "hch@lst.de" <hch@lst.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 28, 2022 at 2:40 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: guoren@kernel.org
> > Sent: 27 February 2022 16:28
> >
> > From: Christoph Hellwig <hch@lst.de>
> >
> > Provide a single common definition for the compat_flock and
> > compat_flock64 structures using the same tricks as for the native
> > variants.  Another extra define is added for the packing required on
> > x86.
> ...
> > diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
> ...
> >  /*
> > - * IA32 uses 4 byte alignment for 64 bit quantities,
> > - * so we need to pack this structure.
> > + * IA32 uses 4 byte alignment for 64 bit quantities, so we need to pack the
> > + * compat flock64 structure.
> >   */
> ...
> > +#define __ARCH_NEED_COMPAT_FLOCK64_PACKED
> >
> >  struct compat_statfs {
> >       int             f_type;
> > diff --git a/include/linux/compat.h b/include/linux/compat.h
> > index 1c758b0e0359..a0481fe6c5d5 100644
> > --- a/include/linux/compat.h
> > +++ b/include/linux/compat.h
> > @@ -258,6 +258,37 @@ struct compat_rlimit {
> >       compat_ulong_t  rlim_max;
> >  };
> >
> > +#ifdef __ARCH_NEED_COMPAT_FLOCK64_PACKED
> > +#define __ARCH_COMPAT_FLOCK64_PACK   __attribute__((packed))
> > +#else
> > +#define __ARCH_COMPAT_FLOCK64_PACK
> > +#endif
> ...
> > +struct compat_flock64 {
> > +     short           l_type;
> > +     short           l_whence;
> > +     compat_loff_t   l_start;
> > +     compat_loff_t   l_len;
> > +     compat_pid_t    l_pid;
> > +#ifdef __ARCH_COMPAT_FLOCK64_PAD
> > +     __ARCH_COMPAT_FLOCK64_PAD
> > +#endif
> > +} __ARCH_COMPAT_FLOCK64_PACK;
> > +
>
> Provided compat_loff_t are correctly defined with __aligned__(4)
See include/asm-generic/compat.h

typedef s64 compat_loff_t;

Only:
#ifdef CONFIG_COMPAT_FOR_U64_ALIGNMENT
typedef s64 __attribute__((aligned(4))) compat_s64;

So how do you think compat_loff_t could be defined with __aligned__(4)?

> marking the structure packed isn't needed.
> I believe compat_u64 and compat_s64 both have aligned(4).
> It is also wrong, consider:
>
> struct foo {
>         char x;
>         struct compat_flock64 fl64;
> };
>
> There should be 3 bytes of padding after 'x'.
> But you've removed it.
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
