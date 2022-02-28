Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0514C6BE5
	for <lists+linux-arch@lfdr.de>; Mon, 28 Feb 2022 13:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbiB1MOS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 07:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbiB1MOO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 07:14:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB6B26102;
        Mon, 28 Feb 2022 04:13:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85EA061148;
        Mon, 28 Feb 2022 12:13:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6787C340FA;
        Mon, 28 Feb 2022 12:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646050413;
        bh=m+Mr/LSWoSX8OkgGcblK1edJYBHkvQ8ETiM4gpOKC3I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rIMwDp96WEceKeR//qBV3hW3RflLbT7Ri6SkOJyFuYr1Umz7PSvd2tJnyGzsnCuOS
         zkRyMuoLF4OGwgS+f/Wsr1lbvrKVwKD+GgZo0lF48j2T2ja0JkL5vU+2vdoz2hSosg
         6OQVRAqUsoJ0aCkxHUP/njxd/M/ACV6bVFgUaP4nROyg0nDWrG1O6p88Q0nPMOvat3
         zrPnrEukqvielX4IAh9Uetd+2K27NDb3zp1Ca3sodR1USsvoivi8RrwikZlQbMWRVF
         Fsv3mZNjmf5ZYFYlQ1CQ2WNC6HV9skutTKtKfLL6m3wkMUQgl4m9/NbufixetgZfFh
         dohrw6mir2x7g==
Received: by mail-vs1-f43.google.com with SMTP id e5so12663197vsg.12;
        Mon, 28 Feb 2022 04:13:33 -0800 (PST)
X-Gm-Message-State: AOAM53274Zx73OLfBNHXH3Q0UXsqeVvWRE2mPpuzYWX6hSsdN6RIejRT
        XCQcmG49q/DJgT63OspcKXfWneqwinAo6fIkqmA=
X-Google-Smtp-Source: ABdhPJyOu5HUo/VjwWn8/fo2A1Ybsum6GvVfDzqE4Hcq0Flfey7YjZaD85t/OqXDAvijqsqOBSTjjzgFI7EmcLKksiE=
X-Received: by 2002:a05:6102:3a12:b0:31e:6646:b3d1 with SMTP id
 b18-20020a0561023a1200b0031e6646b3d1mr4905201vsu.51.1646050412829; Mon, 28
 Feb 2022 04:13:32 -0800 (PST)
MIME-Version: 1.0
References: <20220227162831.674483-1-guoren@kernel.org> <20220227162831.674483-4-guoren@kernel.org>
 <b8e765910e274c0fb574ff23f88b881c@AcuMS.aculab.com> <CAJF2gTRQ0XWSjoEeREtEGr5PPD-rHrBKFY_i6_9uW3eEN_6muQ@mail.gmail.com>
 <e5ee4f6799704bd59b0c580157a05d2d@AcuMS.aculab.com>
In-Reply-To: <e5ee4f6799704bd59b0c580157a05d2d@AcuMS.aculab.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 28 Feb 2022 20:13:22 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQhFK55z4juC7uHpWmHsEXSOkbMyXeid6KsnhfPRo7wqg@mail.gmail.com>
Message-ID: <CAJF2gTQhFK55z4juC7uHpWmHsEXSOkbMyXeid6KsnhfPRo7wqg@mail.gmail.com>
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

On Mon, Feb 28, 2022 at 8:02 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Guo Ren
> > Sent: 28 February 2022 11:52
> >
> > On Mon, Feb 28, 2022 at 2:40 PM David Laight <David.Laight@aculab.com> wrote:
> > >
> > > From: guoren@kernel.org
> > > > Sent: 27 February 2022 16:28
> > > >
> > > > From: Christoph Hellwig <hch@lst.de>
> > > >
> > > > Provide a single common definition for the compat_flock and
> > > > compat_flock64 structures using the same tricks as for the native
> > > > variants.  Another extra define is added for the packing required on
> > > > x86.
> > > ...
> > > > diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
> > > ...
> > > >  /*
> > > > - * IA32 uses 4 byte alignment for 64 bit quantities,
> > > > - * so we need to pack this structure.
> > > > + * IA32 uses 4 byte alignment for 64 bit quantities, so we need to pack the
> > > > + * compat flock64 structure.
> > > >   */
> > > ...
> > > > +#define __ARCH_NEED_COMPAT_FLOCK64_PACKED
> > > >
> > > >  struct compat_statfs {
> > > >       int             f_type;
> > > > diff --git a/include/linux/compat.h b/include/linux/compat.h
> > > > index 1c758b0e0359..a0481fe6c5d5 100644
> > > > --- a/include/linux/compat.h
> > > > +++ b/include/linux/compat.h
> > > > @@ -258,6 +258,37 @@ struct compat_rlimit {
> > > >       compat_ulong_t  rlim_max;
> > > >  };
> > > >
> > > > +#ifdef __ARCH_NEED_COMPAT_FLOCK64_PACKED
> > > > +#define __ARCH_COMPAT_FLOCK64_PACK   __attribute__((packed))
> > > > +#else
> > > > +#define __ARCH_COMPAT_FLOCK64_PACK
> > > > +#endif
> > > ...
> > > > +struct compat_flock64 {
> > > > +     short           l_type;
> > > > +     short           l_whence;
> > > > +     compat_loff_t   l_start;
> > > > +     compat_loff_t   l_len;
> > > > +     compat_pid_t    l_pid;
> > > > +#ifdef __ARCH_COMPAT_FLOCK64_PAD
> > > > +     __ARCH_COMPAT_FLOCK64_PAD
> > > > +#endif
> > > > +} __ARCH_COMPAT_FLOCK64_PACK;
> > > > +
> > >
> > > Provided compat_loff_t are correctly defined with __aligned__(4)
> > See include/asm-generic/compat.h
> >
> > typedef s64 compat_loff_t;
> >
> > Only:
> > #ifdef CONFIG_COMPAT_FOR_U64_ALIGNMENT
> > typedef s64 __attribute__((aligned(4))) compat_s64;
> >
> > So how do you think compat_loff_t could be defined with __aligned__(4)?
>
> compat_loff_t should be compat_s64 not s64.
>
> The same should be done for all 64bit 'compat' types.
Changing
typedef s64 compat_loff_t;
to
typedef compat_s64 compat_loff_t;

should be another patch and it affects all architectures, I don't
think we should involve it in this series.

look at kernel/power/user.c:
struct compat_resume_swap_area {
        compat_loff_t offset;
        u32 dev;
} __packed;

I thnk keep "typedef s64 compat_loff_t;" is a sensible choice for
COMPAT support patchset series.

>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
