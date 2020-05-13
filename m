Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E621D1162
	for <lists+linux-arch@lfdr.de>; Wed, 13 May 2020 13:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbgEMLbi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 May 2020 07:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730057AbgEMLbi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2020 07:31:38 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F7DC061A0C;
        Wed, 13 May 2020 04:31:37 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h17so11548068wrc.8;
        Wed, 13 May 2020 04:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/Ambzc4/RQrE8zBZcRlDSvAzyYdjLZsqZpGTxOVxtr0=;
        b=QxVlO5EpxuoGUAVznRFFCdjta+iNxfYDREGBKQEWv8zTC3mmGObqSi59xTbY/TGnm3
         TkVd1nIDzDWGJOlIS0CTH+PenpBdEP6U2ArhnmgvnsEJJvHhuPAPdcFWf2kXjqtHTL0b
         XQY9SATlyiPR2dUVUdCc7btv9fut5KFSBHoML7uVWCUirGAjWW8bFFfmoxSsrgLE7K3d
         1NzViolD3wX4P+iJjY2Ou3ls8O19OsH8PI3hGHG/46XNUoXJs6K1hUoYjDNBpRlXhDll
         TjEaNywDzD51TKjdj+ECWNyX3PchC5hx6gfQXPVsMvppWrjcOmLxE6UjepyydcmucMnS
         59Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Ambzc4/RQrE8zBZcRlDSvAzyYdjLZsqZpGTxOVxtr0=;
        b=JRSk7IbJ9Py7XCt6rXkglGEX1pN79WwmulFaP7KOIjv1zq8vZ8g9okSDWPrxBIc5BG
         Ujl06YNdzgeQixOVWYbLNpvxx2iwdneAqIf0StSV4+dA2qabyYTOluD/0KwLcymVPgJ+
         S3j0R78xME0/AmzjmFvCqzJsbpHgIHjoLjUALHX2EH5/FItzMMdQBDIMU68U8kMdnUnd
         YwnXaDDPGTKDKgAfeVOiF9N0gfvMo49gbhmiGIpr7u1PbMiQNEuuJ58ajbKd8/a5OeZS
         JfuozIQB3XVzry428fZcPIuxngRLB9gn+9vFH90uFNhqNjgn0SvrwCxvsAgKX7I200y9
         Ke6Q==
X-Gm-Message-State: AGi0PuYeitdQQ4N2m2kWv7Nkgl3DRrOJfMHgYcGTBO2+8xWoqQ/GM5m0
        sLy4nMPY1CemQnl5zbkgmkr6haJQ
X-Google-Smtp-Source: APiQypLzco78WgZlr7iRl0WAyVLGO1SbGEBrquQGC0nEqqBBWSQo6DLxXxLcgN/LeDuecWnVXkPNoQ==
X-Received: by 2002:a5d:49ca:: with SMTP id t10mr22120919wrs.285.1589369496335;
        Wed, 13 May 2020 04:31:36 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id w9sm28742611wrc.27.2020.05.13.04.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 04:31:35 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 05/14] prctl.2: tfix listing order of prctls
To:     Dave Martin <Dave.Martin@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-6-git-send-email-Dave.Martin@arm.com>
 <1bb991f4-176a-a74e-01fc-c73b49ed77f5@gmail.com>
 <20200513112133.GH21779@arm.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <6ef9a969-3e16-e21c-f047-e5a471cbc163@gmail.com>
Date:   Wed, 13 May 2020 13:31:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513112133.GH21779@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Dave,

On 5/13/20 1:21 PM, Dave Martin wrote:
> On Wed, May 13, 2020 at 12:10:53PM +0200, Michael Kerrisk (man-pages) wrote:
>> Hi Dave,
>>
>> On 5/12/20 6:36 PM, Dave Martin wrote:
>>> The prctl list has historically been sorted by prctl name (ignoring
>>> any SET_ or GET_ prefix) to make individual prctls easier to find.
>>> Some noise seems to have crept in since.
>>>
>>> Sort the list back into order.  Similarly, reorder the list of
>>> prctls specified to return non-zero values on success.
>>
>> This is a good patch. But see my comments on patch 04.
>> I'd prefer a patch like this at the end of a series, 
>> rather than in the middle of it.
> 
> Ack.
> 
> Ideally we could check the order with a script, but that seemed a step
> too far.

Quite.

> What's the view on having parts of the man pages generated, rather then
> being distributed ready-built?

I'm not keen (until someone shows me compelling benefits). Splitting
things up would make pages harder to edit, and IMO increase
the chance for inconsistencies in pages.

> If we split prctl.2 up with a fragment per prctl, we could paste the
> fragments together in the right order with a script.
> 
>>
>>> Content movement only.  No semantic change.
>>
>> And explicitly noting that detail is very helpful to me.
> 
> Unless of course I'm lying ;)  (I'm not, but I won't be offended if you
> check.)

Actually, with your first two patches, you impressed right out of
the gate, so my "I'm gonna blindly trust this guy" needle already
switched up pretty high :-).

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
