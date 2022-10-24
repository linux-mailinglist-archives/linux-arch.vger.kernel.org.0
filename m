Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A29060B923
	for <lists+linux-arch@lfdr.de>; Mon, 24 Oct 2022 22:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiJXUFL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Oct 2022 16:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbiJXUEr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Oct 2022 16:04:47 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554481669BD;
        Mon, 24 Oct 2022 11:25:49 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id y14so6959647ejd.9;
        Mon, 24 Oct 2022 11:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:subject:from:references:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=69LcZzU5hZbA58GvMHIPitCdsVL44ZarIKrTqICwzW4=;
        b=y7IwfOxqnc9/1hsPAc9NM/W5RDRRBFT4BCfUGD28x2/TRh/NVT+fa5uy70LC0bdzJS
         3JwEoYA2fz28m09moyyg5JSbyZe9CpeED3b0MrH7f0nKGvQPckNovhpHx+daJa6POUas
         NIvJs06qMJBcBKgbkmb8BFUYDawHPxA56WYS+1pYreDJIDWIUR2D1I64mSCY7rN8TkHr
         oIHgTzxTC5bBX5DotRvrLxZL1eyo7zU3gSpRHC0Yuu74Bx7AVAFKGNiYQkzru6MNhykd
         negIlWtjdMLcJ8S+k8qbbvWhul8JAG2VueyurSnyF2ov/ITLjZgrch39qtGcwtV/Ipy3
         ZlNQ==
X-Gm-Message-State: ACrzQf27lbRbGU/6ud0yRjLvTreq4BA+xiQEZCaUZYN0hI0fEnzCF6t9
        jk8TAfNZRW/KbQ2cVsRsRbU=
X-Google-Smtp-Source: AMsMyM6rbntrv1V4U9FCmxGo0InoNtMIj4Hhk9qbw5320ZABzRLLJTi/MkJzB7yfvww6Jv1k51sdtg==
X-Received: by 2002:a17:907:3207:b0:741:3a59:738d with SMTP id xg7-20020a170907320700b007413a59738dmr28808683ejb.110.1666635892872;
        Mon, 24 Oct 2022 11:24:52 -0700 (PDT)
Received: from [192.168.1.47] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id 27-20020a170906059b00b0078a86e013c4sm233433ejn.61.2022.10.24.11.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 11:24:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------jtZ8QEXoCLEx4rYcRxfUthpP"
Message-ID: <ea468b86-abb7-bb2b-1e0a-4c8959d23f1c@kernel.org>
Date:   Mon, 24 Oct 2022 20:24:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        Michael Matz <matz@suse.de>, Borislav Petkov <bpetkov@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>
References: <20220924181915.3251186-1-masahiroy@kernel.org>
 <20220924181915.3251186-7-masahiroy@kernel.org>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v3 6/7] kbuild: use obj-y instead extra-y for objects
 placed at the head
In-Reply-To: <20220924181915.3251186-7-masahiroy@kernel.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is a multi-part message in MIME format.
--------------jtZ8QEXoCLEx4rYcRxfUthpP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

following an IRC discussion with many parties...

On 24. 09. 22, 20:19, Masahiro Yamada wrote:
> The objects placed at the head of vmlinux need special treatments:
> 
>   - arch/$(SRCARCH)/Makefile adds them to head-y in order to place
>     them before other archives in the linker command line.
> 
>   - arch/$(SRCARCH)/kernel/Makefile adds them to extra-y instead of
>     obj-y to avoid them going into built-in.a.
> 
> This commit gets rid of the latter.
> 
> Create vmlinux.a to collect all the objects that are unconditionally
> linked to vmlinux. The objects listed in head-y are moved to the head
> of vmlinux.a by using 'ar m'.
> 
> With this, arch/$(SRCARCH)/kernel/Makefile can consistently use obj-y
> for builtin objects.
> 
> There is no *.o that is directly linked to vmlinux. Drop unneeded code
> in scripts/clang-tools/gen_compile_commands.py.
> 
> $(AR) mPi needs 'T' to workaround the llvm-ar bug. The fix was suggested
> by Nathan Chancellor [1].
> 
> [1]: https://lore.kernel.org/llvm/YyjjT5gQ2hGMH0ni@dev-arch.thelio-3990X/
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
...
> --- a/scripts/Makefile.vmlinux_o
> +++ b/scripts/Makefile.vmlinux_o
> @@ -18,7 +18,7 @@ quiet_cmd_gen_initcalls_lds = GEN     $@
>   	$(PERL) $(real-prereqs) > $@
>   
>   .tmp_initcalls.lds: $(srctree)/scripts/generate_initcall_order.pl \
> -		$(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS) FORCE
> +		vmlinux.a $(KBUILD_VMLINUX_LIBS) FORCE

There is a slight problem with this. The kernel built with gcc-LTO does 
not boot. But as I understand it, it's not limited to gcc-LTO only.

On x86, startup_64() is supposed to be at offset >zero< of the image 
(see .Lrelocated()). It was ensured by putting head64.o to the beginning 
of vmlinux (by KBUILD_VMLINUX_OBJS on the LD command-line above). The 
patch above instead packs head64.o into vmlinux.a and then moves it 
using "ar -m" to the beginning (it's in 7/7 of the series IIRC).

The problem is that .o files listed on the LD command line explicitly 
are taken as spelled. But unpacking .a inside LD gives no guarantees on 
the order of packed objects. To quote: "that it happens to work 
sometimes is pure luck." (Correct me guys, if I misunderstood you.)

For x86, the most ideal fix seems to be to fix it in the linker script. 
By putting startup_64() to a different section and handle it in the ld 
script specially -- see the attachment. It should always have been put 
this way, the command line order is only a workaround. But this might 
need more fixes on other archs too -- I haven't take a look.

Ideas, comments? I'll send the attachment as a PATCH later (if there are 
no better suggestions).

thanks,
-- 
js
suse labs

--------------jtZ8QEXoCLEx4rYcRxfUthpP
Content-Type: text/x-patch; charset=UTF-8; name="0001-head-fix.patch"
Content-Disposition: attachment; filename="0001-head-fix.patch"
Content-Transfer-Encoding: base64

RnJvbSA4NTY1ZTEzZDVkMjllYjMyYmVkOTY3NDI0MDU5MzMxNWYzYmRkN2Y1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKaXJpIFNsYWJ5IDxqc2xhYnlAc3VzZS5jej4KRGF0
ZTogTW9uLCAyNCBPY3QgMjAyMiAxMToxNzowNCArMDIwMApTdWJqZWN0OiBbUEFUQ0hdIGhl
YWQgZml4CgpTaWduZWQtb2ZmLWJ5OiBKaXJpIFNsYWJ5IDxqc2xhYnlAc3VzZS5jej4KLS0t
CiBhcmNoL3g4Ni9rZXJuZWwvaGVhZF82NC5TICAgICB8IDQgKysrLQogYXJjaC94ODYva2Vy
bmVsL3ZtbGludXgubGRzLlMgfCAxICsKIGluY2x1ZGUvbGludXgvaW5pdC5oICAgICAgICAg
IHwgMSArCiAzIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9oZWFkXzY0LlMgYi9hcmNoL3g4Ni9r
ZXJuZWwvaGVhZF82NC5TCmluZGV4IGQ4NjBkNDM3NjMxYi4uNDE3YmNkOWRhM2RmIDEwMDY0
NAotLS0gYS9hcmNoL3g4Ni9rZXJuZWwvaGVhZF82NC5TCisrKyBiL2FyY2gveDg2L2tlcm5l
bC9oZWFkXzY0LlMKQEAgLTM5LDggKzM5LDggQEAgTDRfU1RBUlRfS0VSTkVMID0gbDRfaW5k
ZXgoX19TVEFSVF9LRVJORUxfbWFwKQogTDNfU1RBUlRfS0VSTkVMID0gcHVkX2luZGV4KF9f
U1RBUlRfS0VSTkVMX21hcCkKIAogCS50ZXh0Ci0JX19IRUFECiAJLmNvZGU2NAorCV9fSEVB
RF9GSVJTVAogU1lNX0NPREVfU1RBUlRfTk9BTElHTihzdGFydHVwXzY0KQogCVVOV0lORF9I
SU5UX0VNUFRZCiAJLyoKQEAgLTEyNiw2ICsxMjYsOCBAQCBTWU1fQ09ERV9TVEFSVF9OT0FM
SUdOKHN0YXJ0dXBfNjQpCiAJam1wIDFmCiBTWU1fQ09ERV9FTkQoc3RhcnR1cF82NCkKIAor
CV9fSEVBRAorCiBTWU1fQ09ERV9TVEFSVChzZWNvbmRhcnlfc3RhcnR1cF82NCkKIAlVTldJ
TkRfSElOVF9FTVBUWQogCUFOTk9UQVRFX05PRU5EQlIKZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2tlcm5lbC92bWxpbnV4Lmxkcy5TIGIvYXJjaC94ODYva2VybmVsL3ZtbGludXgubGRzLlMK
aW5kZXggMTVmMjkwNTNjZWM0Li5hMTBhOWM1MGJjM2YgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2
L2tlcm5lbC92bWxpbnV4Lmxkcy5TCisrKyBiL2FyY2gveDg2L2tlcm5lbC92bWxpbnV4Lmxk
cy5TCkBAIC0xMjYsNiArMTI2LDcgQEAgU0VDVElPTlMKIAkJX3RleHQgPSAuOwogCQlfc3Rl
eHQgPSAuOwogCQkvKiBib290c3RyYXBwaW5nIGNvZGUgKi8KKwkJS0VFUCgqKC5oZWFkLmZp
cnN0LnRleHQpKQogCQlIRUFEX1RFWFQKIAkJVEVYVF9URVhUCiAJCVNDSEVEX1RFWFQKZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvaW5pdC5oIGIvaW5jbHVkZS9saW51eC9pbml0LmgK
aW5kZXggY2E4MjdlMmZiMGRhLi4zYTExZDE5ZTM5Y2YgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUv
bGludXgvaW5pdC5oCisrKyBiL2luY2x1ZGUvbGludXgvaW5pdC5oCkBAIC05Miw2ICs5Miw3
IEBACiAjZGVmaW5lIF9fbWVtZXhpdGNvbnN0ICAgX19zZWN0aW9uKCIubWVtZXhpdC5yb2Rh
dGEiKQogCiAvKiBGb3IgYXNzZW1ibHkgcm91dGluZXMgKi8KKyNkZWZpbmUgX19IRUFEX0ZJ
UlNUCS5zZWN0aW9uCSIuaGVhZC5maXJzdC50ZXh0IiwiYXgiCiAjZGVmaW5lIF9fSEVBRAkJ
LnNlY3Rpb24JIi5oZWFkLnRleHQiLCJheCIKICNkZWZpbmUgX19JTklUCQkuc2VjdGlvbgki
LmluaXQudGV4dCIsImF4IgogI2RlZmluZSBfX0ZJTklUCQkucHJldmlvdXMKLS0gCjIuMzgu
MAoK

--------------jtZ8QEXoCLEx4rYcRxfUthpP--
