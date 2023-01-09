Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8A26629F4
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jan 2023 16:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237303AbjAIPb7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Jan 2023 10:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjAIPbl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jan 2023 10:31:41 -0500
Received: from fx304.security-mail.net (smtpout30.security-mail.net [85.31.212.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A74965D5
        for <linux-arch@vger.kernel.org>; Mon,  9 Jan 2023 07:30:54 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by fx304.security-mail.net (Postfix) with ESMTP id A7F2A9D0C2
        for <linux-arch@vger.kernel.org>; Mon,  9 Jan 2023 16:30:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1673278252;
        bh=2Ol4WvfIDv/pCXWodkK/JAf2l0CqXaG0EOhqPlCz5xY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=kz8ddZYg0nJtow93ucAH7WnT8Vqwhr3lvi4IHN8OoSZGNmOScb2xcOeU4ahhPcX9+
         p9CNBdA/jH2f4K049TrCPM610wwO1NQ4J9xx87Kmzbu7GXz0K8YSAee6gE4pfS7J3i
         nAosaoMAGS6mHOvc8xjvjf4lK/Nd1xrz4y1l10bc=
Received: from fx304 (localhost [127.0.0.1]) by fx304.security-mail.net
 (Postfix) with ESMTP id 520CF9D07F; Mon,  9 Jan 2023 16:30:52 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx304.security-mail.net (Postfix) with ESMTPS id 9D11C9D072; Mon,  9 Jan
 2023 16:30:51 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 68AED27E0402; Mon,  9 Jan 2023
 16:30:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 38EF527E03FF; Mon,  9 Jan 2023 16:30:51 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 Ax--sd_V2azt; Mon,  9 Jan 2023 16:30:51 +0100 (CET)
Received: from [192.168.37.161] (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 8E4D827E03FE; Mon,  9 Jan 2023
 16:30:50 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <b2fe.63bc332b.9bc13.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 38EF527E03FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1673278251;
 bh=AQRkX8OfPpkm9ao22SwrZcjsHp5YTFXu85Lp04m+1A0=;
 h=Message-ID:Date:MIME-Version:To:From;
 b=Nw9h4dkzOwPn5vuhGKIyNNJs3P3x4pfdYEE7ckz9lL13tSkmK4nwamwpUjampl3D6
 LDhJg2t6qBuoBWDfEIexbrFwLh9D9VyJiOWUlwmQC+1j7iIHZ+vEfgfvPWRc9vt9zD
 PN1+BJeuI0U91Om91ZCvoSBebX3S3D5TsBEjM/tE=
Message-ID: <bccad498-3af2-08f1-8264-cf7b438732d3@kalray.eu>
Date:   Mon, 9 Jan 2023 16:30:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH 00/25] Upstream kvx Linux port
Content-Language: en-us
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, bpf@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        devicetree@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
        Eric Paris <eparis@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jason Baron <jbaron@akamai.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Kieran Bingham <kbingham@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-audit@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-perf-users@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-riscv@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Piggin <npiggin@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Moore <paul@paul-moore.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, Alex Michon <amichon@kalray.eu>,
        Ashley Lesdalons <alesdalons@kalray.eu>,
        Benjamin Mugnier <mugnier.benjamin@gmail.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Guillaume Missonnier <gmissonnier@kalray.eu>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Jean-Christophe Pince <jcpince@gmail.com>,
        Jonathan Borne <jborne@kalray.eu>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Julian Vetter <jvetter@kalray.eu>,
        Julien Hascoet <jhascoet@kalray.eu>,
        Julien Villette <jvillette@kalray.eu>,
        Louis Morhet <lmorhet@kalray.eu>,
        Luc Michel <lmichel@kalray.eu>,
        Marc =?utf-8?b?UG91bGhpw6hz?= <dkm@kataplop.net>,
        Marius Gligor <mgligor@kalray.eu>,
        Samuel Jones <sjones@kalray.eu>,
        Thomas Costis <tcostis@kalray.eu>,
        Vincent Chardon <vincent.chardon@elsys-design.com>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
 <CAEr6+ECRh_9App18zmcS6FUR81YYhR=n4kGdeZAtQBsdMB55_A@mail.gmail.com>
 <6570d22d-ee19-f8b1-6fb4-bf8865ec4142@kalray.eu>
 <CAEr6+ECPFeokSULpWzYEYLROYHXNA0PtvdUchT37d4_qVA-PKQ@mail.gmail.com>
From:   Yann Sionneau <ysionneau@kalray.eu>
In-Reply-To: <CAEr6+ECPFeokSULpWzYEYLROYHXNA0PtvdUchT37d4_qVA-PKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Jeff,

On 1/9/23 16:11, Jeff Xie wrote:
> On Mon, Jan 9, 2023 at 9:21 PM Yann Sionneau <ysionneau@kalray.eu> wrote:
>> Hi Jeff,
>>
>> On 1/7/23 07:25, Jeff Xie wrote:
>>> Hi,
>>>
>>> On Wed, Jan 4, 2023 at 1:01 AM Yann Sionneau <ysionneau@kalray.eu> wrote:
>>>> [snip]
>>>>
>>>> A kvx toolchain can be built using:
>>>> # install dependencies: texinfo bison flex libgmp-dev libmpc-dev libmpfr-dev
>>>> $ git clone https://github.com/kalray/build-scripts
>>>> $ cd build-scripts
>>>> $ source last.refs
>>>> $ ./build-kvx-xgcc.sh output
>>> I would like to build the kvx-xgcc to compile and test the linux
>>> kernel, but it reported a compile error.
>>> I wonder what version of gcc you are using.
>>>
>>> My build environment:
>>> VERSION="20.04.2 LTS (Focal Fossa)"
>>> gcc version 9.3.0 (Ubuntu 9.3.0-17ubuntu1~20.04)
>>>
>>>
>>> Compile error:
>>> $ ./build-kvx-xgcc.sh output
>>>
>>> ../../binutils/libiberty/fibheap.c: In function ‘fibheap_replace_key_data’:
>>> ../../binutils/libiberty/fibheap.c:38:24: error: ‘LONG_MIN’ undeclared
>>> (first use in this function)
>>>      38 | #define FIBHEAPKEY_MIN LONG_MIN
>>>         |                        ^~~~~~~~
>>> [snip]
>> What SHA1 of https://github.com/kalray/build-scripts are you using?
> I have executed the "source last.refs"

I was referring to the SHA1 of the repo itself (build-scripts).

`last.refs` is a symbolic link which can point to several releases, 
depending on "when" you did the clone.

I am asking this because we recently published new toolchains.

I want to make sure which one you are trying to build.

>> We are building our toolchain on Ubuntu 18.04 / 20.04 and 22.04 without
>> issues, I don't understand why it does not work for you, although indeed
>> the error log you are having pops out on my search engine and seems to
>> be some well known issue.
> Yes, there are many answers on the web, but none of them solve this problem.
>
>> If the build-script does not work for you, you can still use the
>> pre-built toolchains generated by the GitHub automated actions:
>> https://github.com/kalray/build-scripts/releases/tag/v4.11.1 ("latest"
>> means 22.04)
> Thanks, this is the final solution ;-)
Good to see it helped :)

Regards,

-- 

Yann





