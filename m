Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634B24AB508
	for <lists+linux-arch@lfdr.de>; Mon,  7 Feb 2022 07:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiBGGVH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Feb 2022 01:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239061AbiBGFiW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Feb 2022 00:38:22 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9C5C043181;
        Sun,  6 Feb 2022 21:38:21 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id k18so22618586wrg.11;
        Sun, 06 Feb 2022 21:38:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=byr958ymnG7EGtbbRHy8FEsvmnA+OZjvX3uXRPh6Z4E=;
        b=xWqxHPzWfiPnCRWqMX0G6nt9K63YEHMlaBJcreR7keWoEHD6lSiv6awVPqd4pJ0qCe
         W2x50WA2xEAyPlRDIWz4fLCwvHhXiVTL5af2TxBKrfTDnaiyn3k1VFkbivInnHdQoCgG
         hoYQMb4tN+lgoXs+wCsCWIxQqedEdi6kLntDz3mMwoKocuvxtkkS5kzkUao1xTDkhpRC
         EEwIDc7f0hz+a9E10R32pV3K591aB+EOVFTXIZKQwF9qvvsRZaTdmMkr5BnL7kOeG0nR
         ZHwgU4ouzdxx6vBpNGAGzkIyVEu+zCWvS2OmeXNwySP94WLWifeLjXg545u09mBuMtM6
         UdXQ==
X-Gm-Message-State: AOAM533OjWGYDqkxFfHGpPwHdf0tfpLoK/fS3ax+bLKS0jjOfIXqSDZk
        2LHuRrgKfZ1VEwmWDfYOEnlkAukmZLV4ag==
X-Google-Smtp-Source: ABdhPJwPLsGKwDunoy8I0Myez3SxQ6VYLq3bfG33of6vYqoVy/EKGY4dAvht6XnNrJZEz+OnSQ488A==
X-Received: by 2002:adf:d1c6:: with SMTP id b6mr8399158wrd.669.1644212299712;
        Sun, 06 Feb 2022 21:38:19 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id f14sm8693006wmq.40.2022.02.06.21.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Feb 2022 21:38:18 -0800 (PST)
Message-ID: <35f29dbd-04ec-037e-007c-7a079caf0d5b@kernel.org>
Date:   Mon, 7 Feb 2022 06:38:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/3] vstatus: Display an informational message when the
 VSTATUS character is pressed or TIOCSTAT ioctl is called.
Content-Language: en-US
To:     Walt Drummond <walt@drummond.us>, agordeev@linux.ibm.com,
        arnd@arndb.de, benh@kernel.crashing.org, borntraeger@de.ibm.com,
        chris@zankel.net, davem@davemloft.net, gregkh@linuxfoundation.org,
        hca@linux.ibm.com, deller@gmx.de, ink@jurassic.park.msu.ru,
        James.Bottomley@HansenPartnership.com, mattst88@gmail.com,
        jcmvbkbc@gmail.com, mpe@ellerman.id.au, paulus@samba.org,
        rth@twiddle.net, dalias@libc.org, tsbogend@alpha.franken.de,
        gor@linux.ibm.com, ysato@users.osdn.me
Cc:     linux-kernel@vger.kernel.org, ar@cs.msu.ru,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
References: <20220206154856.2355838-1-walt@drummond.us>
 <20220206154856.2355838-4-walt@drummond.us>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220206154856.2355838-4-walt@drummond.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 06. 02. 22, 16:48, Walt Drummond wrote:
> When triggered by pressing the VSTATUS key or calling the TIOCSTAT
> ioctl, the n_tty line discipline will display a message on the user's
> tty that provides basic information about the system and an
> 'interesting' process in the current foreground process group, eg:
> 
>    load: 0.58  cmd: sleep 744474 [sleeping] 0.36r 0.00u 0.00s 0% 772k
> 
> The status message provides:
>   - System load average
>   - Command name and process id (from the perspective of the session)
>   - Scheduler state
>   - Total wall-clock run time
>   - User space run time
>   - System space run time
>   - Percentage of on-cpu time
>   - Resident set size
> 
> The message is only displayed when the tty has the VSTATUS character
> set, the local flags ICANON and IEXTEN are enabled and NOKERNINFO is
> disabled; it is always displayed when TIOCSTAT is called regardless of
> tty settings.
> 
> Signed-off-by: Walt Drummond <walt@drummond.us>
> ---

It looks like my comments were addressed. However you did not document 
the chances since v1 here. IOW, [v2] tag missing here.

And please add the CCs I added last time, so that relevant people still 
can comment.

thanks,
-- 
js
suse labs
