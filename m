Return-Path: <linux-arch+bounces-1163-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F204881C672
	for <lists+linux-arch@lfdr.de>; Fri, 22 Dec 2023 09:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54256B21F8E
	for <lists+linux-arch@lfdr.de>; Fri, 22 Dec 2023 08:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B895CA59;
	Fri, 22 Dec 2023 08:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="Sj34BkSx"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9040C8F9;
	Fri, 22 Dec 2023 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1703233395; x=1703838195; i=deller@gmx.de;
	bh=MqZgoimzUABcqVdqZ74x7o6tQHZptscqCGyWf1vLEY8=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Sj34BkSxsIfrgCVmJXwfh2uL9Z5pFVsW8mewYCBJnt4Jk/tTZWUX3DD+AIGWbX+J
	 DLG23/NGr8NgI39Ut6ZPifDsJtcoMNnOvaLNafwEOsotDxJTp2OUlEddWhiL2332q
	 rq9ZO4pqXGtWZkBqQMushEwTZS9w9WuxYXgsdqWkcnDgTIWsr8a8sExWtOCs4tihZ
	 GmzZ6V+AZJL1F8b11uQPEiL8BtmJhtEjPhpN1gnCfc/KykrwNRDeBgbrd02o267Rs
	 n7bgBLIliB1xHYSAzqoVhImgU29qWBKWSLjhBcj/zW9udY1wL+1yGbBQ7Oo16r6PX
	 8TclkRM4QvMfsMzHzg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.157.108]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3DO3-1rHQA232TN-003eYR; Fri, 22
 Dec 2023 09:23:15 +0100
Message-ID: <bb34147d-4e67-456a-b0d6-965699cda596@gmx.de>
Date: Fri, 22 Dec 2023 09:23:14 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Section alignment issues?
To: Masahiro Yamada <masahiroy@kernel.org>, deller@kernel.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-modules@vger.kernel.org, linux-arch@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>
References: <20231122221814.139916-1-deller@kernel.org>
 <CAK7LNAQZO0g-B7UUEvdJWh3FhdhmWaaSaJyyEUoVoSYG0j8v-Q@mail.gmail.com>
 <CAK7LNASk=A4aeMuhUt4NGi5RHedcQ_WQrdN3r7S_x0euvsPUXA@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAK7LNASk=A4aeMuhUt4NGi5RHedcQ_WQrdN3r7S_x0euvsPUXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:av7WhO7m5Epi+xgBhaQL15t4R9VG8acHnUpLiaS9Q7fLrwILzuL
 YIaupZZoU8XckFgwlNhAJmKNQLd6MX06+M3vu9X5QMv93y6GcqIuohgrZLey6Rctrj0CeMG
 jPoHk+k4WhTbf9wjQcr5PnNckLN1MiszpGzBNybR3ewSmARX+LsH4ewehhoJkVq5+0vCV9s
 FgWS75/30PhNjfDNXuf8Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UflBrlhezVk=;uSvyXd/kvq4ylUrvKs2NxAZtzjx
 WTmTEKyyA5bmv+9SN+q8aEluHD/267pc0j4Bl+ITMvFUohIfOfvMZZQYbJrXzy0dZ5bqN5cmK
 Y431M8JV9Cb53Mu2U/9RlGFr8FNG5kqM38I0wBoufz4xTXQtZzISIFdLwmPQEx8OFvL4fhZp5
 Ljl/Uxst/o5niV1t3IDpGpmtX0Tu6t+sSUlcGslZasOeKo+WfYfuLM6WgmlEWGAozytHmSSlR
 CJO262NXb82YU7YIM7WDpHEqPivVED9wmelmuUZutcBr3NwNc2RmjxNyhT7+zf4jvXaBVspO5
 Ef0onkWhzd693veShBPBrLK+XK9HlLFV/zR6aMLxJ0yw1XaQ1vjM3G16kqO5ZxmLvahNZp/vm
 QeiBqb81IAO1gXRwG3O0rEIag4ihJgssMXHLTaf+GhQ452eT1hNfQbyOAfUHy8Mmp01WHR+ON
 q2DcJDOoNS+kAela/ydSm3aq3WyIBkdoF3lcsBk8Ck3vp+L2JMzC7MocfBh7dB+MPDZVJpOGk
 03oe96vCVrahK09eb5hxtH0KLevKpWHLn8mkAHZesPzLOPonO6gSOFd8QM30bGsdPvY9vFNB9
 3Naqn5p6WW3v4BhnkBrpRjqzb8CCYZCKf0EN+S3eMqdP1ulQ6lbISUhN3/wp54Z3ITf2ErXce
 92wIykA0mYIZoqAYowPp+3X/HM7d2xJL3XNsHKj76SU3L+TB+MYmXTus5+Zl4CZPZ2BoNnJDG
 jS/udjOrzfNVsOrZV5POAVW7bcrl1sZlAbwbqwuccuGH3RBCgXuQCfd5fukhAjkMhPXOkZd5W
 H/tqHBlKoUSfT6m/PR38BUHovTHQWIK+9oaC/1dxyGRiFhbRKmj4Qq7tUFhCtrFV5yuCHMB7q
 LL0oQUsgjAL9hAdbQc5Fu5gdrxfEXo1Aymn2/tqaPBeY/wNv/jJvkrIbRLJltM8cJzHlvNBYW
 Boe0SmMM8tHLeJtOnDGaZ67+r5I=

On 12/21/23 16:42, Masahiro Yamada wrote:
> On Thu, Dec 21, 2023 at 10:40=E2=80=AFPM Masahiro Yamada <masahiroy@kern=
el.org> wrote:
>>
>> On Thu, Nov 23, 2023 at 7:18=E2=80=AFAM <deller@kernel.org> wrote:
>>>
>>> From: Helge Deller <deller@gmx.de>
>>>
>>> While working on the 64-bit parisc kernel, I noticed that the __ksymta=
b[]
>>> table was not correctly 64-bit aligned in many modules.
>>> The following patches do fix some of those issues in the generic code.
>>>
>>> But further investigation shows that multiple sections in the kernel a=
nd in
>>> modules are possibly not correctly aligned, and thus may lead to perfo=
rmance
>>> degregations at runtime (small on x86, huge on parisc, sparc and other=
s which
>>> need exception handlers). Sometimes wrong alignments may also be simpl=
y hidden
>>> by the linker or kernel module loader which pulls in the sections by l=
uck with
>>> a correct alignment (e.g. because the previous section was aligned alr=
eady).
>>>
>>> An objdump on a x86 module shows e.g.:
>>>
>>> ./kernel/net/netfilter/nf_log_syslog.ko:     file format elf64-x86-64
>>> Sections:
>>> Idx Name          Size      VMA               LMA               File o=
ff  Algn
>>>    0 .text         00001fdf  0000000000000000  0000000000000000  00000=
040  2**4
>>>                    CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
>>>    1 .init.text    000000f6  0000000000000000  0000000000000000  00002=
020  2**4
>>>                    CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
>>>    2 .exit.text    0000005c  0000000000000000  0000000000000000  00002=
120  2**4
>>>                    CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
>>>    3 .rodata.str1.8 000000dc  0000000000000000  0000000000000000  0000=
2180  2**3
>>>                    CONTENTS, ALLOC, LOAD, READONLY, DATA
>>>    4 .rodata.str1.1 0000030a  0000000000000000  0000000000000000  0000=
225c  2**0
>>>                    CONTENTS, ALLOC, LOAD, READONLY, DATA
>>>    5 .rodata       000000b0  0000000000000000  0000000000000000  00002=
580  2**5
>>>                    CONTENTS, ALLOC, LOAD, READONLY, DATA
>>>    6 .modinfo      0000019e  0000000000000000  0000000000000000  00002=
630  2**0
>>>                    CONTENTS, ALLOC, LOAD, READONLY, DATA
>>>    7 .return_sites 00000034  0000000000000000  0000000000000000  00002=
7ce  2**0
>>>                    CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
>>>    8 .call_sites   0000029c  0000000000000000  0000000000000000  00002=
802  2**0
>>>                    CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
>>>
>>> In this example I believe the ".return_sites" and ".call_sites" should=
 have
>>> an alignment of at least 32-bit (4 bytes).
>>>
>>> On other architectures or modules other sections like ".altinstruction=
s" or
>>> "__ex_table" may show up wrongly instead.
>>>
>>> In general I think it would be beneficial to search for wrong alignmen=
ts at
>>> link time, and maybe at runtime.
>>>
>>> The patch at the end of this cover letter
>>> - adds compile time checks to the "modpost" tool, and
>>> - adds a runtime check to the kernel module loader at runtime.
>>> And it will possibly show false positives too (!!!)
>>> I do understand that some of those sections are not performce critical
>>> and thus any alignment is OK.
>>>
>>> The modpost patch will emit at compile time such warnings (on x86-64 k=
ernel build):
>>>
>>> WARNING: modpost: vmlinux: section .initcall7.init (type 1, flags 2) h=
as alignment of 1, expected at least 4.
>>> Maybe you need to add ALIGN() to the modules.lds file (or fix modpost)=
 ?
>>> WARNING: modpost: vmlinux: section .altinstructions (type 1, flags 2) =
has alignment of 1, expected at least 2.
>>> WARNING: modpost: vmlinux: section .initcall6.init (type 1, flags 2) h=
as alignment of 1, expected at least 4.
>>> WARNING: modpost: vmlinux: section .initcallearly.init (type 1, flags =
2) has alignment of 1, expected at least 4.
>>> WARNING: modpost: vmlinux: section .rodata.cst2 (type 1, flags 18) has=
 alignment of 2, expected at least 64.
>>> WARNING: modpost: vmlinux: section .static_call_tramp_key (type 1, fla=
gs 2) has alignment of 1, expected at least 8.
>>> WARNING: modpost: vmlinux: section .con_initcall.init (type 1, flags 2=
) has alignment of 1, expected at least 8.
>>> WARNING: modpost: vmlinux: section __bug_table (type 1, flags 3) has a=
lignment of 1, expected at least 4.
>>> ...
>>
>>
>>
>>
>> modpost acts on vmlinux.o instead of vmlinux.
>>
>>
>> vmlinux.o is a relocatable ELF, which is not a real layout
>> because no linker script has been considered yet at this
>> point.
>>
>>
>> vmlinux is an executable ELF, produced by a linker,
>> with the linker script taken into consideration
>> to determine the final section/symbol layout.
>>
>>
>> So, checking this in modpost is meaningless.
>>
>>
>>
>> I did not check the module checking code, but
>> modules are also relocatable ELF.
>
>
>
> Sorry, I replied too early.
> (Actually I replied without reading your modpost code).
>
> Now, I understand what your checker is doing.
>
>
> I did not test how many false positives are produced,
> but it catches several suspicious mis-alignments.

Yes.

> However, I am not convinced with this warning.
>
>
> +               warn("%s: section %s (type %d, flags %lu) has
> alignment of %d, expected at least %d.\n"
> +                    "Maybe you need to add ALIGN() to the modules.lds
> file (or fix modpost) ?\n",
> +                    modname, sec, sechdr->sh_type, sechdr->sh_flags,
> is_shalign, should_shalign);
> +       }
>
>
> Adding ALGIN() hides the real problem.

Right.
It took me some time to understand the effects here too.
See below...

> I think the real problem is that not enough alignment was requested
> in the code.
>
> For example, the right fix for ".initcall7.init" should be this:
>
> diff --git a/include/linux/init.h b/include/linux/init.h
> index 3fa3f6241350..650311e4b215 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -264,6 +264,7 @@ extern struct module __this_module;
>   #define ____define_initcall(fn, __stub, __name, __sec)         \
>          __define_initcall_stub(__stub, fn)                      \
>          asm(".section   \"" __sec "\", \"a\"            \n"     \
> +           ".balign 4                                  \n"     \
>              __stringify(__name) ":                      \n"     \
>              ".long      " __stringify(__stub) " - .     \n"     \
>              ".previous                                  \n");   \
>
> Then, "this section requires at least 4 byte alignment"
> is recorded in the sh_addralign field.

Yes, this is the important part.

> Then, the rest is the linker's job.
>
> We should not tweak the linker script.

That's right, but let's phrase it slightly different...
There is *no need* to tweak the linker script, *if* the alignment
gets correctly assigned by the inline assembly (like your
initcall patch above).
But on some platforms (e.g. on parisc) I noticed that this .balign
was missing for some other sections, in which case the other (not preferre=
d)
possible option is to tweak the linker script.

So I think we agree that fixing the inline assembly is the right
way to go?

Either way, a link-time check like the proposed modpost patch
may catch section issue for upcoming/newly added sections too.

Helge

