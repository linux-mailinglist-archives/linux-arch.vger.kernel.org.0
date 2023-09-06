Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9690979344E
	for <lists+linux-arch@lfdr.de>; Wed,  6 Sep 2023 06:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237291AbjIFELK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Sep 2023 00:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjIFELJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Sep 2023 00:11:09 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9B9184;
        Tue,  5 Sep 2023 21:11:03 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-57354433a7dso1772916eaf.1;
        Tue, 05 Sep 2023 21:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693973463; x=1694578263; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P4FZa087hyUqZvPa7tIhMq2JMpJjYeVOov7QoimEdp4=;
        b=hV89rb+8pICVikBKpMTckHNK728tYtMtW9DWi9+jocNkox4ZEIGkrwT3X4nDlxLTzh
         9SctQPGWJf2KVzLhWSaSp4lySt9tEac7Zl3JC6G8iqFbkxZ2FeAq5PLKKhsrUmiqCLLj
         IIe//Ck6uqAIpToYDTrlcozLDZUcKWqm3mv1Jk9rp3YVSY9eLFR9jT25JLzP3yCkv8HE
         VT3oaJj/VuuIBk+Q6gAdHsL12q3pD8vxSvUsXZna5UEbgKUVmA7jFmXIw1YBtbeoTbvG
         ZzIQiZsIMXefyVJi4WXuint54z1Ivbtp/2BQQuqCSPPHcpnpNSFvOkwxsxF+iEZ4Wm1m
         DJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693973463; x=1694578263;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P4FZa087hyUqZvPa7tIhMq2JMpJjYeVOov7QoimEdp4=;
        b=Hqd9qnU/k+MOB3J5oBxMNeTbMneJ6kBu3yulO45ueF7Gk0nhpVOw2LZyQBRGQOpM/n
         VEhPLabqqVSZt27UAXvdVCfYuHbzXCYEyfdF9lScX6M+RMBw5A5diNUpmjU2faZRWw/f
         mbheTVnBJ4xkO82m+Zl0fH3kvoYoAAbHLJAu23li4kBlglTG4qYTr/GXz5WDcsXevlSZ
         mdMHG6RhvParX/2sRKa6h4OCumR0PoPpwazg4AblirukP+5cLx4Z47hrNhbDsFVHg2kC
         NwiPUx9/4tq5nD9BY6QUqx5ajK7Q3vZPKOXOuooxCnTWi2ObZK4G/o0aXeY6IXUs/IWD
         TLKA==
X-Gm-Message-State: AOJu0YyegvKs233rWlKvmJeY0YBzqiQ1OMyjBSmgvWqIyALIkGnyecRu
        WVPm53zf+XDpHAYq7GQsOckTW8Nup5KbuAf5UDY=
X-Google-Smtp-Source: AGHT+IGrUiiHqpj6nSPCM7SRQ+tOP84EbjN8VTSNYKFwWPnKr2m7q6WYy7JED9MP9psbE5K9AaPZo0mllOegzNcsmOA=
X-Received: by 2002:a4a:314b:0:b0:56c:cd04:9083 with SMTP id
 v11-20020a4a314b000000b0056ccd049083mr12638895oog.1.1693973463099; Tue, 05
 Sep 2023 21:11:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:745a:0:b0:4f0:1250:dd51 with HTTP; Tue, 5 Sep 2023
 21:11:02 -0700 (PDT)
In-Reply-To: <CAHk-=wh0J7HotWcjP5nL4pZZLZN31SMid5rpf3pvmv-7Yi2W1A@mail.gmail.com>
References: <20230830140315.2666490-1-mjguzik@gmail.com> <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
 <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com>
 <CAHk-=wh+=W2k1V_0Om=_=QpPAN_VgHzdZ4FLXSfcyTSK7xo0Eg@mail.gmail.com>
 <CAHk-=wg6bzTdQHSsswHPYFUbb1DfszyWTZ97hZv7bYxaNHVkHw@mail.gmail.com>
 <20230903204858.lv7i3kqvw6eamhgz@f> <CAHk-=wjYOZf2wPj_=arATJ==DQQAQwh0ki=Za0RcE542rWBGFw@mail.gmail.com>
 <ZPT/LzkPR/jaiaDb@gmail.com> <CAHk-=wh1hi-HnBQRu9_ALQL-fbhyn_go+2c9FajO26khf2dsTw@mail.gmail.com>
 <CAGudoHG1_r1B0pz6-HUqb6AfbAgWHxBy+TnimvQtwLLqkKtchA@mail.gmail.com>
 <CAHk-=wjM6KwAvC9+sCAm9BgBSspZm60VBLzHcuonGcHrPKJrbw@mail.gmail.com>
 <CAHk-=whnEF7-+DL+71wVgnJG1xjeHAQjzqMAULgQq_uhWfP0ZA@mail.gmail.com>
 <CAGudoHENT1yPBD=+xAUTzWxL+iro8CE3+hHLtYiU6j3cCv7PPA@mail.gmail.com>
 <CAHk-=wgjyGX3OVDtzJW6Oh2ukviXtJYi9+7eJW75DgX+d673iw@mail.gmail.com>
 <CAGudoHEXyYSZj-7=3Xss=65jGyX4Lq=R-BdbnmGKJwSS8QznSw@mail.gmail.com> <CAHk-=wh0J7HotWcjP5nL4pZZLZN31SMid5rpf3pvmv-7Yi2W1A@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Wed, 6 Sep 2023 06:11:02 +0200
Message-ID: <CAGudoHFAzfA+PoCYD_XabFAQxow1e32M4Wxf_3AqczKKAtc0Wg@mail.gmail.com>
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

On 9/6/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Tue, 5 Sept 2023 at 13:41, Mateusz Guzik <mjguzik@gmail.com> wrote:
>>
>> @@ -312,7 +314,15 @@ int vfs_fstatat(int dfd, const char __user
>> *filename,
>>         struct filename *name;
>>
>>         name = getname_flags(filename,
>> getname_statx_lookup_flags(statx_flags), NULL);
>> -       ret = vfs_statx(dfd, name, statx_flags, stat, STATX_BASIC_STATS);
>> +       /*
>> +        * Hack: ugliness below damage controls glibc which reimplemented
>> fstat
>> +        * on top of newfstatat(fd, "", buf, AT_EMPTY_PATH). We still pay
>> for
>> +        * kmalloc and user access, but elide lockref.
>> +        */
>> +       if (name->name[0] == '\0' && flags == AT_EMPTY_PATH && dfd >= 0)
>> +               ret = vfs_fstat(dfd, stat);
>> +       else
>> +               ret = vfs_statx(dfd, name, statx_flags, stat,
>> STATX_BASIC_STATS);
>>         putname(name);
>
> I actually think I might prefer the earlier hacky thing, because it
> avoids the whole nasty pathname allocation thing (ie the __getname()
> dance in getname_flags(), and the addition of the pathname to the
> audit records etc).
>
> I suspect your "there are no real loads that combine AT_EMPTY_PATH
> with a path" comment is true.
>
> So if we have this short-circuit of the code, let's go all hog on it,
> and avoid not just the RCU lookup (with lockref etc), but the pathname
> allocation too.
>

Ok, I'm buggering off the subject.

-- 
Mateusz Guzik <mjguzik gmail.com>
