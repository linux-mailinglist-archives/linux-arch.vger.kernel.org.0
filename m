Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8F62EECD4
	for <lists+linux-arch@lfdr.de>; Fri,  8 Jan 2021 06:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbhAHFTH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Jan 2021 00:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbhAHFTG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Jan 2021 00:19:06 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE959C0612F4;
        Thu,  7 Jan 2021 21:18:25 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id v1so3035231pjr.2;
        Thu, 07 Jan 2021 21:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:newsgroups:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aSxKMwdc2LOn2l0PdeifM0S0Y2l05A8yh5PMl2xYblo=;
        b=owhFsaRzICAUXtIRzOEsWNqrBsznL9RP5mZdv1HnNGFwini6cJS7XWXLP5SneT86JJ
         hYJrmSRbH3sbF4eLbZpZhVel0ev0N3uEk9qSYcsqKFnqaYjmV4y+a9+0J3Ljj7ISXW13
         mSCWjc170dWhkGxIsUdzwOPPIQ+dMz1lxSpzjZ2s7KPJZK+qNOhoV/CIUxsIxY6xzoVM
         PN4Q1SZUxw04kkkVFmPBdbcyf0FxEacZfgXrBsXgAr3o0g4Zum7l5puasXgFKAvL6HgG
         HN59tlSQCgS/YRUzyH5TxAuwDfo0klGPIVLpsgilEmF7PQAUvEoPg/zufmo329Agvvfd
         11wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:newsgroups:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=aSxKMwdc2LOn2l0PdeifM0S0Y2l05A8yh5PMl2xYblo=;
        b=hmfm6F36gfec7BsPHLQH7zqEVr0hczGLURot1ULcJtT9gW+ulIrQHuKP8TGnT6tadb
         A8DXe2b068XdJ8iop20t7D/ExhpyzFivrpF+Y7hqY1Qya8mIcp+h9oemGHIwmRiTpGlV
         +ZI6zMoU5NskwIJ58zVQuPD/UMB4bHPU56elbgldKdK8OP2WVeDI9wZa2cFPqp52smaI
         HGHtcO5mJMs2cWZED2a9KNmywpfG2rxtGItcGAX8SxFB8z/yURmrS+UmUA2idYlA2G9G
         1kXudHJSjqhTJt6OCoj90aHBNPIlZDxc8UCmmVGWMyVeOeoiV628nHTXrTFXIT1B79of
         ygtQ==
X-Gm-Message-State: AOAM532OKj4s/jmBdyDqjEbfGF+EuiH2YAzjWEKBIpBMPs3Ve7C57f7Y
        jFs2AsCTPcWpBSF8nbw4myJpYK7kQQ7CShl6
X-Google-Smtp-Source: ABdhPJxHs2I8fgn1/rnaSLlvFAMF8We5+bkxciPAber23woXbNgHmG0Awj6rCjaV0VLtd9ZBUKVh2Q==
X-Received: by 2002:a17:90a:5d03:: with SMTP id s3mr1893827pji.150.1610083105147;
        Thu, 07 Jan 2021 21:18:25 -0800 (PST)
Received: from [192.168.50.50] (c-24-4-73-83.hsd1.ca.comcast.net. [24.4.73.83])
        by smtp.gmail.com with ESMTPSA id w2sm7351029pfj.110.2021.01.07.21.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 21:18:24 -0800 (PST)
Sender: Vineet Gupta <vineetg76@gmail.com>
Subject: Re: ARC no console output (was Re: [PATCH 1/2] init/console: Use
 ttynull as a fallback when there is no console)
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        shreyasjoshi15@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, buildroot@busybox.net,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arch@vger.kernel.org,
        arcml <linux-snps-arc@lists.infradead.org>
Newsgroups: gmane.linux.kernel.cross-arch,gmane.linux.kernel,gmane.linux.kernel.arc
References: <20201111135450.11214-1-pmladek@suse.com>
 <20201111135450.11214-2-pmladek@suse.com>
 <d2a3b3c0-e548-7dd1-730f-59bc5c04e191@synopsys.com>
 <8735zdm86m.fsf@jogness.linutronix.de>
 <50ade852-c598-6476-1f4b-9a3f8d11d143@synopsys.com> <X/c/ONCYz2QQdvOP@alley>
 <466644f5-bed7-caef-9fcd-e66208f65545@synopsys.com>
 <X/fWGjYI5LapMdGW@jagdpanzerIV.localdomain>
From:   Vineet Gupta <vgupta@synopsys.com>
Message-ID: <d7db7948-4831-8dac-0d16-7933bcd9d995@synopsys.com>
Date:   Thu, 7 Jan 2021 21:18:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <X/fWGjYI5LapMdGW@jagdpanzerIV.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/7/21 7:48 PM, Sergey Senozhatsky wrote:
> On (21/01/07 09:58), Vineet Gupta wrote:
>> On 1/7/21 9:04 AM, Petr Mladek wrote:
>>> On Thu 2021-01-07 08:43:16, Vineet Gupta wrote:
>>>> Hi John,
>>>>
>>>> On 1/7/21 1:02 AM, John Ogness wrote:
>>>>> Hi Vineet,
>>>>>
>>>>> On 2021-01-06, Vineet Gupta <vgupta@synopsys.com> wrote:
>>>>>> This breaks ARC booting (no output on console).
>>>>>
>>>>> Could you provide the kernel boot arguments that you use? This series is
>>>>> partly about addressing users that have used boot arguments that are
>>>>> technically incorrect (even if had worked). Seeing the boot arguments of
>>>>> users that are not experiencing problems may help to reveal some of the
>>>>> unusual console usages until now.
>>>>
>>>>
>>>> Kernel command line: earlycon=uart8250,mmio32,0xf0005000,115200n8
>>>> console=ttyS0,115200n8 debug print-fatal-signals=1
>>>
>>> This is strange, the problematic patch should use ttynull
>>> only as a fallback. It should not be used when a particular console
>>> is defined on the command line.
>>
>> What happens in my case is console_on_rootfs() doesn't find /dev/console and
>> switching to ttynull. /dev is not present because devtmpfs doesn't automount
>> for initramfs.
> 
> I wonder if we'll move the nulltty fallback logic into printk code [1]
> will it fix the problem?
> 
> [1] https://lore.kernel.org/lkml/X6x%2FAxD1qanC6evJ@jagdpanzerIV.localdomain/

Your reasoning in the post above makes total sense.

I tired the patch: adding register_ttynull_console() call in 
console_device(), removing from console_on_rootfs() band that works too.


| Warning: unable to open an initial console. Fallback to ttynull.
| Warning: Failed to add ttynull console. No stdin, stdout, and stderr 
for the init process!
| Freeing unused kernel memory: 3096K
| This architecture does not have kernel memory protection.
| Run /init as init process
| with arguments:
|    /init
|  with environment:
|    HOME=/
|    TERM=linux
| Starting System logger (syslogd)
| Bringing up loopback device
| Starting inetd
| Mounting Posix Mqueue filesys
| 
CONFIG_INITRAMFS_SOURCE="~/arc/RAMFS/archs/ramfs_2011-GNU-2020-03-glibc-2.32-tiny"
| **********************************************************************
|			Welcome to ARCLinux
| **********************************************************************
| [ARCLinux]#
