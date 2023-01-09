Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A86F66222C
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jan 2023 10:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbjAIJxT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Jan 2023 04:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236769AbjAIJwx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jan 2023 04:52:53 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4B4DBE
        for <linux-arch@vger.kernel.org>; Mon,  9 Jan 2023 01:52:08 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-476e643d1d5so106327637b3.1
        for <linux-arch@vger.kernel.org>; Mon, 09 Jan 2023 01:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAQX3MqHqmIeeOrJpELRmG+wNnU+MpmXY1sRh1DUmgw=;
        b=DVfCyJ6P3zydmckWF8seSRRw/mz6qUyyH0LrKVrsvYJAZ/YNG6Mq5wFaD140cl5+Ib
         KiwpsqJymIId+h5o6qdfMB7wX7OXUI2ziy601EpVhnGbLTKmKyVlreUcACXdSKp2UX1X
         OEsiE8fMyPqTic7T67qLgNRVijQzlvX36bNwYY6KadKvfTzd04RqtNTnUybSKV0q0opJ
         AyOtbJ0FhWJZOqZK9RWfIz6xTGeFVie2Br5pGFEwBS2NK3FWOS897lhpxVuX91WtQmTt
         uABX3Qfc1ng4EIsFPSNo2PrSp4Lu0ObHJmsT0hTGTqxBNz1sN2YYnL5uU+/N+w1QdPZW
         tL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAQX3MqHqmIeeOrJpELRmG+wNnU+MpmXY1sRh1DUmgw=;
        b=MtkdW0B0Xks84Zo+peMCvtQMYeNsTA4UoVEktUMRg+suhrUuBhb+WR6RdA6xmwq8Mv
         LIglNTZBNUlc4D24ItfNV1sAiqVcx55N/lGcB9hYIHediFstMXTlvfFOxA4wZWYAqRW+
         E0Nzz2/HqhzooHoN8nnH+IFknQaoXqqdv5hJrWt1Yh2NZ+kWJu4Y1Zp92IyQWcf1d3m8
         5xP9h51QQE6Pect6C3QB4A5hWUsUSACtQGTYq9Nd53rnyHrYINeVbwgGEdOyxxUA42gH
         UPTB7On9k0ABQfuFjb8Y5l+Ll8Z/tLFmqF58rDhZOz+4uv2Y3DyShUwLAuQEPayMTf8s
         8LsQ==
X-Gm-Message-State: AFqh2krIeMjaIYeQxROckslOmzWnnZ4uHPlQ527krFyHWhtbljeun3mP
        Cf3b0MPjUEok8YLQwIbtVvnM1t4nzsZ25h5Ss0+rGw==
X-Google-Smtp-Source: AMrXdXuGvJK/Z2GNIYTIcilU/lRPpom25Exjk2m/eTsYGxQGzPycGsZ6tbA4IcBTD/gP8jy9E/3DFgSf/xXGY41i0OE=
X-Received: by 2002:a0d:f084:0:b0:4c2:51b:796c with SMTP id
 z126-20020a0df084000000b004c2051b796cmr993316ywe.144.1673257927353; Mon, 09
 Jan 2023 01:52:07 -0800 (PST)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-11-glider@google.com>
 <CANpmjNOYqXSw5+Sxt0+=oOUQ1iQKVtEYHv20=sh_9nywxXUyWw@mail.gmail.com>
 <CAG_fn=W2EUjS8AX1Odunq1==dV178s_-w3hQpyrFBr=Auo-Q-A@mail.gmail.com> <63b74a6e6a909_c81f0294a5@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <63b74a6e6a909_c81f0294a5@dwillia2-xfh.jf.intel.com.notmuch>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 9 Jan 2023 10:51:30 +0100
Message-ID: <CAG_fn=WjrzaHLfgw7ByFvguHA8z0MA-ZB3Kd0d6CYwmZWVEgjA@mail.gmail.com>
Subject: Re: [PATCH v4 10/45] libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Marco Elver <elver@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 5, 2023 at 11:09 PM Dan Williams <dan.j.williams@intel.com> wro=
te:
>
> Alexander Potapenko wrote:
> > (+ Dan Williams)
> > (resending with patch context included)
> >
> > On Mon, Jul 11, 2022 at 6:27 PM Marco Elver <elver@google.com> wrote:
> > >
> > > On Fri, 1 Jul 2022 at 16:23, Alexander Potapenko <glider@google.com> =
wrote:
> > > >
> > > > KMSAN adds extra metadata fields to struct page, so it does not fit=
 into
> > > > 64 bytes anymore.
> > >
> > > Does this somehow cause extra space being used in all kernel configs?
> > > If not, it would be good to note this in the commit message.
> > >
> > I actually couldn't verify this on QEMU, because the driver never got l=
oaded.
> > Looks like this increases the amount of memory used by the nvdimm
> > driver in all kernel configs that enable it (including those that
> > don't use KMSAN), but I am not sure how much is that.
> >
> > Dan, do you know how bad increasing MAX_STRUCT_PAGE_SIZE can be?
>
> Apologies I missed this several months ago. The answer is that this
> causes everyone creating PMEM namespaces on v6.1+ to lose double the
> capacity of their namespace even when not using KMSAN which is too
> wasteful to tolerate. So, I think "6e9f05dc66f9 libnvdimm/pfn_dev:
> increase MAX_STRUCT_PAGE_SIZE" needs to be reverted and replaced with
> something like:
>
> diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
> index 79d93126453d..5693869b720b 100644
> --- a/drivers/nvdimm/Kconfig
> +++ b/drivers/nvdimm/Kconfig
> @@ -63,6 +63,7 @@ config NVDIMM_PFN
>         bool "PFN: Map persistent (device) memory"
>         default LIBNVDIMM
>         depends on ZONE_DEVICE
> +       depends on !KMSAN
>         select ND_CLAIM
>         help
>           Map persistent memory, i.e. advertise it to the memory
>
>
> ...otherwise, what was the rationale for increasing this value? Were you
> actually trying to use KMSAN for DAX pages?

I was just building the kernel with nvdimm driver and KMSAN enabled.
Because KMSAN adds extra data to every struct page, it immediately hit
the following assert:

drivers/nvdimm/pfn_devs.c:796:3: error: call to
__compiletime_assert_330 declared with 'error' attribute: BUILD_BUG_ON
fE
                BUILD_BUG_ON(sizeof(struct page) > MAX_STRUCT_PAGE_SIZE);

The comment before MAX_STRUCT_PAGE_SIZE declaration says "max struct
page size independent of kernel config", but maybe we can afford
making it dependent on CONFIG_KMSAN (and possibly other config options
that increase struct page size)?

I don't mind disabling the driver under KMSAN, but having an extra
ifdef to keep KMSAN support sounds reasonable, WDYT?



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
