Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D86AF1B95
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2019 17:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732270AbfKFQsB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Nov 2019 11:48:01 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38547 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbfKFQsB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Nov 2019 11:48:01 -0500
Received: by mail-qt1-f196.google.com with SMTP id p20so16119165qtq.5;
        Wed, 06 Nov 2019 08:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MzNNnoxjIXcfrQoBiiSLakyntgDDsi/Earrv6kug0R8=;
        b=qyCaOULNKtVGLG70WuHmAuxF9XIpktX1MCo8sB+9E0MWioLM2Cua6fVZzsmc3w8V5n
         usKVE9Anca97lrAbnwz5e72nW8r5m+1G0S7jn663IU1CEsngMwK5CGqE16bESeFu2bAt
         vAEPgfGmp8gjfSlQ+s5epwqETFeOW8AoW43NlTfAasU9rbARdpfeV+M0cwE8m3+6uXhm
         raTMsFuxO7yi8hn+Tc+o2/JIg6iWBN0XBrzRTEYD/RMHn4Y/7seUm3vcBPN7zYPWWAgX
         YlrcPOmXtVHSUAgu0XckdNzIQDcn/LAseiujIS0ebqFJ+TwQXdFp/bpaUFDrW3bMu/Lh
         NU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MzNNnoxjIXcfrQoBiiSLakyntgDDsi/Earrv6kug0R8=;
        b=X18iIVwUxUTCx/xu70MysJS01kSQ1VmTso10OeVACfJqjfVWFedBS+fP7Be16lmvan
         QP5c/dsTaKKUi1fc7SOYMhQFc7y/Rcjdc/vJy6hGcvg2kq68+jJ2SYz1ky4X4myAXCCL
         yq7mdhfcSGVNv0DDhqjz7H5MPqS2bbY3MmZVUvyYwAAxF7LptUkfF9nOZn9xxL4be8c+
         w0Wwu00eafqJNJg7Q5KynwD7OVgu/ZytIa77x2NWGEMXKg4YLSvJOA2UGpI7re8nCyVF
         QVvtzH9Zbcc4PCjkVMlwquR9Jg9Ndh6y/RflHfgyPm9YPRLsy7cb3w5VHuTgr058oCKV
         8jyw==
X-Gm-Message-State: APjAAAUsEVco7hGb/WPoavmwu1eX0A305CNOjGLxqXb5xTOsite4IIES
        JMCKZQ0Ip3pzSj9IMJ5DZrrGnofNM3BaUWdv
X-Google-Smtp-Source: APXvYqwNQVr00bZouV3s5S9KSz61fF0IG9g+WZpUitNwCMwhrwJZ3M+lm4C0ZNchsJtXmqaGNrlTfA==
X-Received: by 2002:ac8:7188:: with SMTP id w8mr3228984qto.211.1573058879657;
        Wed, 06 Nov 2019 08:47:59 -0800 (PST)
Received: from gmail.com (public-246-115.nat.utoronto.ca. [138.51.246.115])
        by smtp.gmail.com with ESMTPSA id x10sm16034045qtj.25.2019.11.06.08.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 08:47:58 -0800 (PST)
Date:   Wed, 6 Nov 2019 11:47:56 -0500
From:   Mohammad Nasirifar <far.nasiri.m@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mohammad Nasirifar <farnasirim@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>
Subject: Re: [PATCH 1/1] syscalls: Fix references to filenames containing
 syscall defs
Message-ID: <20191106164756.GA558585@gmail.com>
References: <20191105022928.517526-1-farnasirim@gmail.com>
 <alpine.DEB.2.21.1911051033050.17054@nanos.tec.linutronix.de>
 <CAK8P3a0wyw=CwhiU34t1zBiSesf+HGBLeaV+=JVko_TjnvATHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK8P3a0wyw=CwhiU34t1zBiSesf+HGBLeaV+=JVko_TjnvATHQ@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 05, 2019 at 10:49:12AM +0100, Arnd Bergmann wrote:
>On Tue, Nov 5, 2019 at 10:34 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> On Mon, 4 Nov 2019, Mohammad Nasirifar wrote:
>> > Fix stale references to files containing syscall definitions in
>> > 'include/linux/syscalls.h' and 'include/uapi/asm-generic/unistd.h',
>> > pointing to 'kernel/itimer.c', 'kernel/hrtimer.c', and 'kernel/time.c'.
>> > They are now under 'kernel/time'.
>> >
>> > Also definitions of 'getpid', 'getppid', 'getuid', 'geteuid', 'getgid',
>> > 'getegid', 'gettid', and 'sysinfo' are now in 'kernel/sys.c'.
>>
>> Can we please remove these file references completely. They are going to be
>> stale sooner than later again and they really do not provide any value.
I actually refer to them a lot when locating syscall implementations,
which is how I found out that they were stale in the first place.
>
>+1
>
>Good idea!
>
>In the long run, I'd prefer to have a parsable format that can be used to
>generate both the header file and the stubs that we currently provide
>using SYSCALL_DEFINEx(), but before that I'd like the remaining two
>unistd.h files to be converted to syscall.tbl format (Nitesh is still working
>on that).
Sorry I didn't understand, is there anything I can do to follow up on this?
>
>      Arnd

