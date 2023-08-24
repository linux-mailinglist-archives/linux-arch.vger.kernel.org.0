Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CA3786CEE
	for <lists+linux-arch@lfdr.de>; Thu, 24 Aug 2023 12:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240005AbjHXKjw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Aug 2023 06:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240814AbjHXKj2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Aug 2023 06:39:28 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF67719AE;
        Thu, 24 Aug 2023 03:39:18 -0700 (PDT)
Received: from pwmachine.localnet (85-170-34-233.rev.numericable.fr [85.170.34.233])
        by linux.microsoft.com (Postfix) with ESMTPSA id 12D3F2127C7E;
        Thu, 24 Aug 2023 03:39:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 12D3F2127C7E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692873558;
        bh=sADkn8tyKPEO16o0GbANLDuNQfMjSQjCtM0kk6kWOiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aZMTuurF26Asywaf/muB6/j1rBzPEOkfaKVzO1h/B5VAU6i2Ndv4Ac/KhfBRsopVV
         DZApvoOfhFdgvY3KSQVOCLzXbMNz4g79KxuvCEt7bf7isr7pAZ17fsl6KSQa2jRopr
         Ypj2lftkw5V/JRfJK+uGkYtXpTh8KitNBT0nNmls=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobes: Return ENAMESVRLSYMS when func matches several symbols
Date:   Thu, 24 Aug 2023 12:39:12 +0200
Message-ID: <2695869.mvXUDI8C0e@pwmachine>
In-Reply-To: <20230824085355.4fdd6215f71b0fa5f443d76d@kernel.org>
References: <20230823161410.103489-1-flaniel@linux.microsoft.com> <20230823161410.103489-2-flaniel@linux.microsoft.com> <20230824085355.4fdd6215f71b0fa5f443d76d@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi.

Le jeudi 24 ao=FBt 2023, 01:53:55 CEST Masami Hiramatsu a =E9crit :
> Hi Francis,
>=20
> On Wed, 23 Aug 2023 18:14:10 +0200
>=20
> Francis Laniel <flaniel@linux.microsoft.com> wrote:
> > Previously to this commit, if func matches several symbols, a PMU kprobe
> > would be installed for the first matching address.
> > This could lead to some misunderstanding when some BPF code was never
> > called because it was attached to a function which was indeed not call,
> > because the effectively called one has no kprobes.
> >=20
> > So, this commit introduces ENAMESVRLSYMS which is returned when func
> > matches several symbols.
>=20
> The trace_kprobe part looks good to me.
> But sorry, I mislead you. I meant using an existing error code as a
> metaphor. EINVAL is used everywhere, so choose another error code, e.g.
> EADDRNOTAVAIL.

No problem, I was a bit in doubt regarding adding a new error code, but at=
=20
least I learnt how to do it if one day I need to do so!
But yes, for this case, better to use an existing one!

> Also, can you add this check in __trace_kprobe_create()?
> I think right before below code, at that point, 'symbol' has the symbol
> name.
>=20
>         trace_probe_log_set_index(0);
>         if (event) {
>                 ret =3D traceprobe_parse_event_name(&event, &group, gbuf,
>                                                   event - argv[0]);
>                 if (ret)
>                         goto parse_error;
>         }

Addressed in v2, thank you!

>=20
> Thank you,
>=20
> > This way, user needs to use addr to remove the ambiguity.
> >=20
> > Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> > Link:
> > https://lore.kernel.org/lkml/20230819101105.b0c104ae4494a7d1f2eea742@ke=
rn
> > el.org/ ---
> >=20
> >  arch/alpha/include/uapi/asm/errno.h        |  2 ++
> >  arch/mips/include/uapi/asm/errno.h         |  2 ++
> >  arch/parisc/include/uapi/asm/errno.h       |  2 ++
> >  arch/sparc/include/uapi/asm/errno.h        |  2 ++
> >  include/uapi/asm-generic/errno.h           |  2 ++
> >  kernel/trace/trace_kprobe.c                | 26 ++++++++++++++++++++++
> >  tools/arch/alpha/include/uapi/asm/errno.h  |  2 ++
> >  tools/arch/mips/include/uapi/asm/errno.h   |  2 ++
> >  tools/arch/parisc/include/uapi/asm/errno.h |  2 ++
> >  tools/arch/sparc/include/uapi/asm/errno.h  |  2 ++
> >  tools/include/uapi/asm-generic/errno.h     |  2 ++
> >  11 files changed, 46 insertions(+)
> >=20
> > diff --git a/arch/alpha/include/uapi/asm/errno.h
> > b/arch/alpha/include/uapi/asm/errno.h index 3d265f6babaf..3d9686d915f9
> > 100644
> > --- a/arch/alpha/include/uapi/asm/errno.h
> > +++ b/arch/alpha/include/uapi/asm/errno.h
> > @@ -125,4 +125,6 @@
> >=20
> >  #define EHWPOISON	139	/* Memory page has hardware error */
> >=20
> > +#define ENAMESVRLSYMS	140	/* Name correspond to several symbols */
> > +
> >=20
> >  #endif
> >=20
> > diff --git a/arch/mips/include/uapi/asm/errno.h
> > b/arch/mips/include/uapi/asm/errno.h index 2fb714e2d6d8..1fd64ee7b629
> > 100644
> > --- a/arch/mips/include/uapi/asm/errno.h
> > +++ b/arch/mips/include/uapi/asm/errno.h
> > @@ -124,6 +124,8 @@
> >=20
> >  #define EHWPOISON	168	/* Memory page has hardware error */
> >=20
> > +#define ENAMESVRLSYMS	169	/* Name correspond to several symbols */
> > +
> >=20
> >  #define EDQUOT		1133	/* Quota exceeded */
> >=20
> > diff --git a/arch/parisc/include/uapi/asm/errno.h
> > b/arch/parisc/include/uapi/asm/errno.h index 87245c584784..c7845ceece26
> > 100644
> > --- a/arch/parisc/include/uapi/asm/errno.h
> > +++ b/arch/parisc/include/uapi/asm/errno.h
> > @@ -124,4 +124,6 @@
> >=20
> >  #define EHWPOISON	257	/* Memory page has hardware error */
> >=20
> > +#define ENAMESVRLSYMS	258	/* Name correspond to several symbols */
> > +
> >=20
> >  #endif
> >=20
> > diff --git a/arch/sparc/include/uapi/asm/errno.h
> > b/arch/sparc/include/uapi/asm/errno.h index 81a732b902ee..1ed065943bab
> > 100644
> > --- a/arch/sparc/include/uapi/asm/errno.h
> > +++ b/arch/sparc/include/uapi/asm/errno.h
> > @@ -115,4 +115,6 @@
> >=20
> >  #define EHWPOISON	135	/* Memory page has hardware error */
> >=20
> > +#define ENAMESVRLSYMS	136	/* Name correspond to several symbols */
> > +
> >=20
> >  #endif
> >=20
> > diff --git a/include/uapi/asm-generic/errno.h
> > b/include/uapi/asm-generic/errno.h index cf9c51ac49f9..3d5d5740c8da
> > 100644
> > --- a/include/uapi/asm-generic/errno.h
> > +++ b/include/uapi/asm-generic/errno.h
> > @@ -120,4 +120,6 @@
> >=20
> >  #define EHWPOISON	133	/* Memory page has hardware error */
> >=20
> > +#define ENAMESVRLSYMS	134	/* Name correspond to several symbols */
> > +
> >=20
> >  #endif
> >=20
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index 23dba01831f7..53b66db1ff53 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -1699,6 +1699,16 @@ static int unregister_kprobe_event(struct
> > trace_kprobe *tk)>=20
> >  }
> > =20
> >  #ifdef CONFIG_PERF_EVENTS
> >=20
> > +
> > +static int count_symbols(void *data, unsigned long unused)
> > +{
> > +	unsigned int *count =3D data;
> > +
> > +	(*count)++;
> > +
> > +	return 0;
> > +}
> > +
> >=20
> >  /* create a trace_kprobe, but don't add it to global lists */
> >  struct trace_event_call *
> >  create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
> >=20
> > @@ -1709,6 +1719,22 @@ create_local_trace_kprobe(char *func, void *addr,
> > unsigned long offs,>=20
> >  	int ret;
> >  	char *event;
> >=20
> > +	/*
> > +	 * If user specifies func, we check that the function name does not
> > +	 * correspond to several symbols.
> > +	 * If this is the case, we return with error code ENAMESVRLSYMS to
> > +	 * indicate the user he/she should use addr and offs rather than func=
=20
to
> > +	 * remove the ambiguity.
> > +	 */
> > +	if (func) {
> > +		unsigned int count;
> > +
> > +		count =3D 0;
> > +		kallsyms_on_each_match_symbol(count_symbols, func, &count);
> > +		if (count > 1)
> > +			return ERR_PTR(-ENAMESVRLSYMS);
> > +	}
> > +
> >=20
> >  	/*
> >  =09
> >  	 * local trace_kprobes are not added to dyn_event, so they are never
> >  	 * searched in find_trace_kprobe(). Therefore, there is no concern of
> >=20
> > diff --git a/tools/arch/alpha/include/uapi/asm/errno.h
> > b/tools/arch/alpha/include/uapi/asm/errno.h index
> > 3d265f6babaf..3d9686d915f9 100644
> > --- a/tools/arch/alpha/include/uapi/asm/errno.h
> > +++ b/tools/arch/alpha/include/uapi/asm/errno.h
> > @@ -125,4 +125,6 @@
> >=20
> >  #define EHWPOISON	139	/* Memory page has hardware error */
> >=20
> > +#define ENAMESVRLSYMS	140	/* Name correspond to several symbols */
> > +
> >=20
> >  #endif
> >=20
> > diff --git a/tools/arch/mips/include/uapi/asm/errno.h
> > b/tools/arch/mips/include/uapi/asm/errno.h index
> > 2fb714e2d6d8..1fd64ee7b629 100644
> > --- a/tools/arch/mips/include/uapi/asm/errno.h
> > +++ b/tools/arch/mips/include/uapi/asm/errno.h
> > @@ -124,6 +124,8 @@
> >=20
> >  #define EHWPOISON	168	/* Memory page has hardware error */
> >=20
> > +#define ENAMESVRLSYMS	169	/* Name correspond to several symbols */
> > +
> >=20
> >  #define EDQUOT		1133	/* Quota exceeded */
> >=20
> > diff --git a/tools/arch/parisc/include/uapi/asm/errno.h
> > b/tools/arch/parisc/include/uapi/asm/errno.h index
> > 87245c584784..c7845ceece26 100644
> > --- a/tools/arch/parisc/include/uapi/asm/errno.h
> > +++ b/tools/arch/parisc/include/uapi/asm/errno.h
> > @@ -124,4 +124,6 @@
> >=20
> >  #define EHWPOISON	257	/* Memory page has hardware error */
> >=20
> > +#define ENAMESVRLSYMS	258	/* Name correspond to several symbols */
> > +
> >=20
> >  #endif
> >=20
> > diff --git a/tools/arch/sparc/include/uapi/asm/errno.h
> > b/tools/arch/sparc/include/uapi/asm/errno.h index
> > 81a732b902ee..1ed065943bab 100644
> > --- a/tools/arch/sparc/include/uapi/asm/errno.h
> > +++ b/tools/arch/sparc/include/uapi/asm/errno.h
> > @@ -115,4 +115,6 @@
> >=20
> >  #define EHWPOISON	135	/* Memory page has hardware error */
> >=20
> > +#define ENAMESVRLSYMS	136	/* Name correspond to several symbols */
> > +
> >=20
> >  #endif
> >=20
> > diff --git a/tools/include/uapi/asm-generic/errno.h
> > b/tools/include/uapi/asm-generic/errno.h index cf9c51ac49f9..3d5d5740c8=
da
> > 100644
> > --- a/tools/include/uapi/asm-generic/errno.h
> > +++ b/tools/include/uapi/asm-generic/errno.h
> > @@ -120,4 +120,6 @@
> >=20
> >  #define EHWPOISON	133	/* Memory page has hardware error */
> >=20
> > +#define ENAMESVRLSYMS	134	/* Name correspond to several symbols */
> > +
> >=20
> >  #endif
> >=20
> > --
> > 2.34.1

Best regards.


