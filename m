Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1FB3A5A46
	for <lists+linux-arch@lfdr.de>; Sun, 13 Jun 2021 22:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhFMUJ1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 13 Jun 2021 16:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbhFMUJZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 13 Jun 2021 16:09:25 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A75CC061574
        for <linux-arch@vger.kernel.org>; Sun, 13 Jun 2021 13:07:12 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id e20so7028642pgg.0
        for <linux-arch@vger.kernel.org>; Sun, 13 Jun 2021 13:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=CiYUu2FG3HzlT4zH2YA+/ZlUCQRb2ZZzkBuzJ9thcHg=;
        b=Op9BchT98Ekvvq5+yFv1Av9v0Jsvab6N6w0bAH3htrMV5ViJeJD/jRzt34gMtrSCM0
         k7uFGICDhkWzbAu6cgXVcQGm84zYmOvEVU/tL8yq38HUF1+yTYmCKn3KvNgl6ldTScrW
         VdjSMM25ySwQGpDcP6nEkel71pEG0qToc2XoEZ4uMrZRz34ToIML2T51ea1rfpn7UTF0
         6PPT52qbMJuG7W8Iuu22fDNmxrgvitywUdxQ7MISQaBZ+oldlwlcrvflJZYKCRTijhzo
         SafI+uom8LsXetk3rHLP5tvpmAKWkbQN1IUAWr7gl1Ho+TSLPL72c0D5JlGyL5upUmWl
         AXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=CiYUu2FG3HzlT4zH2YA+/ZlUCQRb2ZZzkBuzJ9thcHg=;
        b=Cs2AdtFxJn4QX2UUYm0ESvoXozQiTCQKe57RMK/MyvtHs6XptVwlGEVVljChSaZYzL
         rpSU6i+3m4ofSWxGGuiy0IYbE8RmIGDRlquCa1JlV9YooE5oYVwZXQkZqzf/9CF6in+M
         yU1/etLyVrp9KGQWYC+7YBO/G74rkfQXe4ZzuQ5544ClnSnblUWNZRP4FPBuzYQJ1qtA
         O0hWWoN4RhkmWxzu1vmwUlsOQKJ5WwWDQiJ+9qh0MZSBcCnXCCX0I3nh3bmuYntJsZiD
         Ap7cKIb8TS2/B1jQPTYBZqHhDZW4R0lvEFfrPZSsNqsO5ncrMV8625b+ghrs+oPBSsrf
         PY2A==
X-Gm-Message-State: AOAM532i5jn507BlP7v8tZugXQSDn69iUVPIkA0Ots+61AxtpgM7paoz
        4i6LKuJx4A29SQCekJo+cCJ7eY5Nim0=
X-Google-Smtp-Source: ABdhPJxVv3j/WmRjOoDTnHDBtdomBVwPGG3nD+/7czESMQbGqO8x8E+Gk7crhOCw4zixdDZhArRljg==
X-Received: by 2002:a63:544e:: with SMTP id e14mr14029347pgm.256.1623614830860;
        Sun, 13 Jun 2021 13:07:10 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:9034:3fbe:cf28:988a? ([2001:df0:0:200c:9034:3fbe:cf28:988a])
        by smtp.gmail.com with ESMTPSA id p11sm10180026pfo.126.2021.06.13.13.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jun 2021 13:07:10 -0700 (PDT)
Subject: Re: [PATCH v1] m68k: save extra registers on sys_exit and
 sys_exit_group syscall entry
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andreas Schwab <schwab@linux-m68k.org>
References: <87sg1p30a1.fsf@disp2133>
 <1623541098-6532-1-git-send-email-schmitzmic@gmail.com>
 <CAHk-=wi2KnsPbv2BOKHa+hb3CmyxsWRQBmSrzqzNezZ=vxH6bg@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <0a96ad37-dedb-67f3-3b27-1ff521c41083@gmail.com>
Date:   Mon, 14 Jun 2021 08:07:04 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wi2KnsPbv2BOKHa+hb3CmyxsWRQBmSrzqzNezZ=vxH6bg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Linus,

On 14/06/21 7:59 am, Linus Torvalds wrote:
> On Sat, Jun 12, 2021 at 4:38 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> do_exit() calls prace_stop() which may require access to all saved
>> registers. We only save those registers not preserved by C code
>> currently.
>>
>> Provide a special syscall entry for exit and exit_group syscalls
>> similar to that used by clone and clone3, which have the same
>> requirements.
> ACK, this looks correct to me.
>
> It might be a good idea to generate a test-case for this - some
> "ptrace child, catch exit of it, show registers" kind of thing - just
> to show what the effects of the bug was (and to show it's fixed). But
> maybe it's not worth the effort.

I'd love that, too. My test rig doesn't allow dumping of registers by 
strace, but someone else may have that capacity.

Cheers,

     Michael

>
>                    Linus
