Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8812A79302A
	for <lists+linux-arch@lfdr.de>; Tue,  5 Sep 2023 22:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjIEUlj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Sep 2023 16:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjIEUli (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Sep 2023 16:41:38 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24942D8;
        Tue,  5 Sep 2023 13:41:35 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1d4e0c2901bso1721735fac.0;
        Tue, 05 Sep 2023 13:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693946494; x=1694551294; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lN8/blfhbXNk42zQ+dhE95HQtpdju1g6GvGHzJNaOwI=;
        b=XaHZK+s9p+pOYVhF+3TOHD7pGcR8pGf6d0dh5VLMBWqUJ07S0uwB0+Hw6+KH39YT0B
         zRw0nZu6tE+/bdjCywp4y7dUQWwvQPNlI1dB7vYlZEMpTFceZ+uIGs1pyqbEUwFUoOJW
         TVk3ZPFOXKyrYR8MBwy3zWmOV4AJUuDyPN24QEbFpX5cXIu+ipAIWfpEwelnqfQ4X/rc
         u0YxU4T8OaJsxT7eDJK2xg368tHDeS3+6HO62HCSnR4KZ8Is/Iehq/UaLEOPAIaTdX2w
         wqlOU//5tKKNL0iMjSoapO9JovylAbLExCaK11QXr87rW7ZOkyhHtyf7nsi/Bq0iJeFJ
         /0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693946494; x=1694551294;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lN8/blfhbXNk42zQ+dhE95HQtpdju1g6GvGHzJNaOwI=;
        b=ObKiImq6Z/HEXQlIUyb6vMQwmUG2BjUZmdXsAz1caLmELVqNPhGu4dbreEjsrV7xzg
         vfMVl02jJx67BAeRMKwjw/8vew63i1+79wyFPAOGzqe4wrJQQJP81/+tH8vZQfam23sP
         GM8k5NZXk4G9JV70Nth+E3u5EFCuPx3J8bCfzJjXisG3rRruPsNdtIfolctwyrkL5rZj
         wBkmWNiMoVs8ymmRXA8r2H77iFbNTmGCMqcyzlkFf9ZrKgprQHZ092YPn/USHal78cY8
         IS9vevtEH2hFnb5Ec+v6RCMEaUr8H2Kspmf/XmzyXQRGaJt+JxzjGXtYZL4b3KE6KW8M
         WNKA==
X-Gm-Message-State: AOJu0YwCB5f1R9kzSG3TOhQCAWE03vWzSib7uSRcYTo41aD6RpqjyWS2
        gcEPOaqY6bCd8Frz8AK8ENbgnKPJeAtKiyzqWb6k8eJt
X-Google-Smtp-Source: AGHT+IFfcSyC12XlgmDD1sbRygiarzs/SN/Tb4fwGhnuRiCcbIPOCV/x7fIYwZdm3uYJFjQOXN4vF8JxITpXs5jQUnQ=
X-Received: by 2002:a05:6870:a11e:b0:1c3:c43d:838 with SMTP id
 m30-20020a056870a11e00b001c3c43d0838mr18588532oae.39.1693946494387; Tue, 05
 Sep 2023 13:41:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:745a:0:b0:4f0:1250:dd51 with HTTP; Tue, 5 Sep 2023
 13:41:33 -0700 (PDT)
In-Reply-To: <CAHk-=wgjyGX3OVDtzJW6Oh2ukviXtJYi9+7eJW75DgX+d673iw@mail.gmail.com>
References: <20230830140315.2666490-1-mjguzik@gmail.com> <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
 <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com>
 <CAHk-=wh+=W2k1V_0Om=_=QpPAN_VgHzdZ4FLXSfcyTSK7xo0Eg@mail.gmail.com>
 <CAHk-=wg6bzTdQHSsswHPYFUbb1DfszyWTZ97hZv7bYxaNHVkHw@mail.gmail.com>
 <20230903204858.lv7i3kqvw6eamhgz@f> <CAHk-=wjYOZf2wPj_=arATJ==DQQAQwh0ki=Za0RcE542rWBGFw@mail.gmail.com>
 <ZPT/LzkPR/jaiaDb@gmail.com> <CAHk-=wh1hi-HnBQRu9_ALQL-fbhyn_go+2c9FajO26khf2dsTw@mail.gmail.com>
 <CAGudoHG1_r1B0pz6-HUqb6AfbAgWHxBy+TnimvQtwLLqkKtchA@mail.gmail.com>
 <CAHk-=wjM6KwAvC9+sCAm9BgBSspZm60VBLzHcuonGcHrPKJrbw@mail.gmail.com>
 <CAHk-=whnEF7-+DL+71wVgnJG1xjeHAQjzqMAULgQq_uhWfP0ZA@mail.gmail.com>
 <CAGudoHENT1yPBD=+xAUTzWxL+iro8CE3+hHLtYiU6j3cCv7PPA@mail.gmail.com> <CAHk-=wgjyGX3OVDtzJW6Oh2ukviXtJYi9+7eJW75DgX+d673iw@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Tue, 5 Sep 2023 22:41:33 +0200
Message-ID: <CAGudoHEXyYSZj-7=3Xss=65jGyX4Lq=R-BdbnmGKJwSS8QznSw@mail.gmail.com>
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/4/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Sun, 3 Sept 2023 at 23:03, Mateusz Guzik <mjguzik@gmail.com> wrote:
>>
>> Worst case if the 64 bit structs differ one can settle for
>> user-accessing INIT_STRUCT_STAT_PADDING.
>
> As I said, try it. I think you'll find that you are wrong.  It's
> _hard_ to get the padding right. The "use a temporary" model of the
> current code makes the fallback easy - just clear it before copying
> the fields. Without that, you have to get every architecture padding
> right manually.
>

See below for an unrelated patch. ;)

In the worst case user-accessing INIT_STRUCT_STAT_PADDING would simply
have these padding assignments spelled out, like you had to do anyway
in your patch (among other things) and which already happens with
existing code for x86-64. The code would not be fully optimized due to
"bad" ordering, but the implementation would avoid escaping fs/stat.c
which imo justifies it.

I said my $0,03 on the matter twice, I don't think this convo is
getting anywhere or that it is particularly important.

With that out of the way:

Earlier you attached a patch to check for an empty path early, that
was a nice win but can result in duplicated smap trips for nasty
software.

Then you mentioned doing the check after the name is fully copied in,
which I incorrectly dismissed from the get go -- mentally I had a
state from $elsewhere where it would require patching namei. But in
Linux this is not the case:

        name = getname_flags(filename,
getname_statx_lookup_flags(statx_flags), NULL);
        ret = vfs_statx(dfd, name, statx_flags, stat, STATX_BASIC_STATS);
        putname(name);

So something like this:

@@ -312,7 +314,15 @@ int vfs_fstatat(int dfd, const char __user *filename,
        struct filename *name;

        name = getname_flags(filename,
getname_statx_lookup_flags(statx_flags), NULL);
-       ret = vfs_statx(dfd, name, statx_flags, stat, STATX_BASIC_STATS);
+       /*
+        * Hack: ugliness below damage controls glibc which reimplemented fstat
+        * on top of newfstatat(fd, "", buf, AT_EMPTY_PATH). We still pay for
+        * kmalloc and user access, but elide lockref.
+        */
+       if (name->name[0] == '\0' && flags == AT_EMPTY_PATH && dfd >= 0)
+               ret = vfs_fstat(dfd, stat);
+       else
+               ret = vfs_statx(dfd, name, statx_flags, stat,
STATX_BASIC_STATS);
        putname(name);

        return ret;

Previous numbers:
> stock fstat     5088199
> patched fstat   7625244 (+49%)
> real fstat      8540383 (+67% / +12%)

while moving the check lower:
patchedv2 fstat 6253694 (+22%)

So quite a bit slower than the hackiest variant, but avoids the double
smap problem for cases passing AT_EMPTY_PATH and a non-"" name.

I think this is a justifiable patch, can submit properly formatted
(this is copy pasted into gmail, sorry). Alternatively since it is
trivial and it was your idea feel free to take it or reimpement or
whatever in similar vein.

-- 
Mateusz Guzik <mjguzik gmail.com>
