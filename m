Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B21FA1838FC
	for <lists+linux-arch@lfdr.de>; Thu, 12 Mar 2020 19:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgCLSuN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Mar 2020 14:50:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36374 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLSuN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Mar 2020 14:50:13 -0400
Received: by mail-pf1-f193.google.com with SMTP id i13so3706340pfe.3;
        Thu, 12 Mar 2020 11:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aVeDcP2GLMR0aX//Ogt1RRYQRRkohGDFdUA0jaq53Qs=;
        b=gj4C0VrzQPslhuNBGtMSI8OT2yTIr8P/zswi8mJJ3PH6iyBRYvwNBypHodDTj/JCK7
         xHCZtvh5DQVMgHPjPEN7rLLaPoZs20Baj76WfG3M9jt1eeylYfqk6zcwB9cDMKU85whl
         /qj4L2tDExjOYjzoxbvCBbrOAMdBXOPMOXxA8d9p1/5C+p7XubT2JbE3JltaQPJFsVvC
         vMqtq5UoJkrJ70I9iroZKn3CbDf0AkxRw4x2a5YhbGhqn+ej4ciOknVMXuWeKW993hlj
         kN3dOxv8MaoFTeaaXLpkKDnBmnN9YvKquKNnW7ZfnhezjeoUvC4W5CPyu7eNGxg6tvsF
         7WAw==
X-Gm-Message-State: ANhLgQ0nVlTvadRKG8Tx/W6q6SvbnUdWfw16j/4ZrxgUqloJ9tU2jMwj
        1zuRKHJCvVJh0DTJaUPfwsjPbpCT/C8=
X-Google-Smtp-Source: ADFU+vuCg/44F2XOXy+VHNIQVrts09wkHYa7AdbHNYs2LVO56aWT9OJhzkComda6rXurlEMfw0mt0A==
X-Received: by 2002:aa7:8d18:: with SMTP id j24mr7484991pfe.264.1584039010335;
        Thu, 12 Mar 2020 11:50:10 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:af99:b4cf:6b17:1075? ([2601:647:4000:d7:af99:b4cf:6b17:1075])
        by smtp.gmail.com with ESMTPSA id n5sm3465841pfq.35.2020.03.12.11.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 11:50:09 -0700 (PDT)
Subject: Re: [PATCH v1] asm-generic: Provide generic {get, put}_unaligned_{l,
 b}e24()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-nvme@lists.infradead.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org
References: <20200312113941.81162-1-andriy.shevchenko@linux.intel.com>
 <efe5daa3-8e37-101a-9203-676be33eb934@acm.org>
 <20200312162507.GF1922688@smile.fi.intel.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <6d932620-3255-fbd8-7fc8-22e4b3068043@acm.org>
Date:   Thu, 12 Mar 2020 11:50:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312162507.GF1922688@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/12/20 9:25 AM, Andy Shevchenko wrote:
> On Thu, Mar 12, 2020 at 08:18:07AM -0700, Bart Van Assche wrote:
>> On 2020-03-12 04:39, Andy Shevchenko wrote:
>>> There are users in kernel that duplicate {get,put}_unaligned_{l,b}e24()
>>> implementation. Provide generic helpers once for all.
>>
>> Hi Andy,
>>
>> Thanks for having done this work. In case you would not yet have noticed
>> the patch series that I posted some time ago but for which I did not
>> have the time to continue working on it, please take a look at
>> https://lore.kernel.org/lkml/20191028200700.213753-1-bvanassche@acm.org/.
> 
> Can you send a new version?
> 
> Also, consider to use byteshift to avoid this limitation:
> "Only use get_unaligned_be24() if reading p - 1 is allowed."

Sure, I will do that and I will also add you to the Cc-list of the patch 
series.

Thanks,

Bart.

