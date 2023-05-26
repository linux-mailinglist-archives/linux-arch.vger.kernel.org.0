Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C800711F29
	for <lists+linux-arch@lfdr.de>; Fri, 26 May 2023 07:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjEZFRs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 May 2023 01:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjEZFRs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 May 2023 01:17:48 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E719313A;
        Thu, 25 May 2023 22:17:46 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-255401f977dso356291a91.2;
        Thu, 25 May 2023 22:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685078266; x=1687670266;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWf9VwGyh647NTiZdevjn4fWRBDqPDisfVmvbRXRIfk=;
        b=ULmbK/tlKpbG/0OYco5YqPz07KIeDGI392FrGQRRd5X/sGjlpCo4a87yBNW3cxtNbA
         W2eYVMaA2t0pOuXYqusBOn/RwRPfdTIvejBaNMhhow4WD5DWff30clr+pstQlXKttF/K
         y0XmmaqFR1A4GwpJGrzCyMMEfj/9kU1JV9qnr0dpR5r1F3wkHhws67vA2GZ6UfapwjSE
         cErl93ME80cFsBEwELelONHD/9FJXi6kqG7eMqMfQsHbSRWhOGG0S9nARk0sNKBS8RIe
         kAMfkfj91SW23srcdehbzbdpr8egtZf+vNR56trcxRm/x4dP1fjuuPgWYf/o64BehtCO
         +0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685078266; x=1687670266;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWf9VwGyh647NTiZdevjn4fWRBDqPDisfVmvbRXRIfk=;
        b=eiBrWja+DOEwMPniGoYboCEvqacJIkdxggfKKiGeb7+8enwhMsUoCCKq/FPsldel4s
         jF//PxFmezrTNKH3vxqpVn22iMsVmp8jJthwhXMknujTLRoSaxsRPuDAQfgjrNZqFWi4
         DjKjWHi4ErVqoM0lLR/dajLbxhzKPygYTE4SAN6z4U+udMjtmN/NGIA9oIPSmzs2eq6p
         riKTvOKayJDsrxgNClP/xdsr0FxaV1nIQLLMM1Kigh3gTDvtQ658zgZSMIm5V+VVLb2H
         9bgXB1T6LJqBB99cdMjd4NUEenT2fS78V2FUS8DrezEor1haRPbAwOxYhWq0/FUxchqM
         c1FA==
X-Gm-Message-State: AC+VfDynP6dihmf/So/bstK32RWUuAVnft8cOKLHErR8MHFHYdsnTEg7
        n7Sdp79yTS+d1kjf4lf3zZ4=
X-Google-Smtp-Source: ACHHUZ6qj8+GYjFiOMejIOa+jxY/i8dC6DUy4jM2Qp7p/YGG0jjxM9Arj0MHjzHoPktoq+Tu9JxGCA==
X-Received: by 2002:a17:902:7788:b0:1a8:ce:afd1 with SMTP id o8-20020a170902778800b001a800ceafd1mr1218262pll.20.1685078265673;
        Thu, 25 May 2023 22:17:45 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902820200b001afd821c057sm2278222pln.58.2023.05.25.22.17.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2023 22:17:45 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH v2 2/3] compiler: inline does not imply notrace
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20230525222844.6a0d84f8@rorschach.local.home>
Date:   Thu, 25 May 2023 22:17:33 -0700
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org,
        linux-um@lists.infradead.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D4B1FB24-C351-411B-8A40-4DAFE95FA921@gmail.com>
References: <20230525210040.3637-1-namit@vmware.com>
 <20230525210040.3637-3-namit@vmware.com>
 <20230525222844.6a0d84f8@rorschach.local.home>
To:     Steven Rostedt <rostedt@goodmis.org>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On May 25, 2023, at 7:28 PM, Steven Rostedt <rostedt@goodmis.org> =
wrote:
>=20
> On Thu, 25 May 2023 14:00:39 -0700
> Nadav Amit <nadav.amit@gmail.com> wrote:
>=20
>> From: Nadav Amit <namit@vmware.com>
>>=20
>> Functions that are marked as "inline" are currently also not =
tracable.
>> This limits tracing functionality for many functions for no reason.
>> Apparently, this has been done for two reasons.
>>=20
>> First, as described in commit 5963e317b1e9d2a ("ftrace/x86: Do not
>> change stacks in DEBUG when calling lockdep"), it was intended to
>> prevent some functions that cannot be traced from being traced as =
these
>> functions were marked as inline (among others).
>>=20
>> Yet, this change has been done a decade ago, and according to Steven
>> Rostedt, ftrace should have improved and hopefully resolved nested
>> tracing issues by now. Arguably, if functions that should be traced -
>> for instance since they are used during tracing - still exist, they
>> should be marked as notrace explicitly.
>>=20
>> The second reason, which Steven raised, is that attaching "notrace" =
to
>> "inline" prevented tracing differences between different configs, =
which
>> caused various problem. This consideration is not very strong, and =
tying
>> "inline" and "notrace" does not seem very beneficial. The "inline"
>> keyword is just a hint, and many functions are currently not tracable
>> due to this reason.
>>=20
>> Disconnect "inline" from "notrace".
>=20
> FYI, I have a patch queued (still needs to go through testing) that
> already does this ;-)
>=20
> =
https://lore.kernel.org/all/20230502164102.1a51cdb4@gandalf.local.home/

Ugh. If you cc=E2=80=99d me, I wouldn=E2=80=99t bother you during your =
vacation. :)

I think you may like the first patch in my series to precede this patch
though as some of the function I marked as =E2=80=9Cnotrace" are =
currently =E2=80=9Cinline=E2=80=9D.

Let me know how you want to proceed, so I would know how to break this
series.

