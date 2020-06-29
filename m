Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6885720E1CA
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jun 2020 23:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731584AbgF2U7c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 16:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731246AbgF2TNB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 15:13:01 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B250C0005E9;
        Mon, 29 Jun 2020 04:52:27 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id l12so16228482ejn.10;
        Mon, 29 Jun 2020 04:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z4T8FYIuY1Y9y77Ieqlt8yjK4mMZI204Yh7+ny2pOxI=;
        b=NSw0+NYOEWUX09qhxIhnQuDptMz9usR2acyi5MT3qtQDq+jauX9JV0dCNi+hWPVZKA
         8PITL1jUFfcQhJboYmU1vI/EQ5kfRyxTWQ2mdSe93/utFbWDgAAn4jX2K2chejuh0RUw
         PVc6VhEVd6bgpByATmWgDNn9QcLyc9jiDyAcd+Kj5gU6D3ToMNpIMN/1ot03nTRx/gYY
         iWVIvcp2xEutzLW5dxNzSdIJgGZUKeYFTjyTpgmrEkHSnqxAx1OYq+20VnYPq/LT6QYU
         Ths+XT2EYO4scy8hAvLNjOZbH0sBhjW7D7TgenH6hwS9ZPS5Gombm09nV7zneDKp9HUF
         Qo3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z4T8FYIuY1Y9y77Ieqlt8yjK4mMZI204Yh7+ny2pOxI=;
        b=sKDr8ozB9dwf+BIP+yOM/F/bWYvc+uvl1Jk5SJjiP+Q0ip2dsxVN+2WkYaAp+toban
         i96LLtJHxhmlV+0XLTtKCtidGnijXVhrmsO1/VUzDmu3+vJxtsS5+R97a4nhyAPysCE2
         Aroc3VISYEobd/XbrtSqlIxmA2Eb3au96q6pCVaKag4E2JX8qFGDzoyM6MpeULXQmCRt
         ZIubiPDuHIMyGLYfocu5iQpVrEIkLvT7YGPvntrYDAX42JmdIphzfYmMaY8VhC5DUd0i
         yPjGMJPqvlY9kXfPg21vMTT2yY1+8RpVYb8/RKgQtgYUa65W48Jue9FnH98YwPenYsMu
         2/Dw==
X-Gm-Message-State: AOAM530+w7k3zenp4VIIEtrhkTaIOneRzOzprBzGen9ZCKF7K8yZ6b6k
        QJR2NPclAXapqR4qDRmHKrc=
X-Google-Smtp-Source: ABdhPJw9VywqY/CryAfoqmrag72OopJvW/lVO6GIt4MIPEZf6gSRTEOjsN3NrsEflaVIfLx4tCcXFA==
X-Received: by 2002:a17:907:7283:: with SMTP id dt3mr13997833ejc.195.1593431545811;
        Mon, 29 Jun 2020 04:52:25 -0700 (PDT)
Received: from ?IPv6:2001:a61:253c:8201:b2fb:3ef8:ca:1604? ([2001:a61:253c:8201:b2fb:3ef8:ca:1604])
        by smtp.gmail.com with ESMTPSA id w8sm28008278eds.41.2020.06.29.04.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 04:52:25 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v3 0/2] prctl.2 man page updates for Linux 5.6
To:     Dave Martin <Dave.Martin@arm.com>
References: <1593020162-9365-1-git-send-email-Dave.Martin@arm.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <c17e330c-69f7-da7a-feae-cb8b8f5d7ea0@gmail.com>
Date:   Mon, 29 Jun 2020 13:52:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1593020162-9365-1-git-send-email-Dave.Martin@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Dave,

On 6/24/20 7:36 PM, Dave Martin wrote:
> A bunch of updates to the prctl(2) man page to fill in missing
> prctls (mostly) up to Linux 5.6 (along with a few other tweaks and
> fixes).
> 
> Patches from the v2 series [1] that have been applied or rejected
> already have been dropped.
> 
> All that remain here now are the SVE and tagged address ABI controls
> for arm64.
> 
> 
> 
> [1] https://lore.kernel.org/linux-man/1590614258-24728-1-git-send-email-Dave.Martin@arm.com/
> 
> 
> Dave Martin (2):
>   prctl.2: Add SVE prctls (arm64)
>   prctl.2: Add tagged address ABI control prctls (arm64)
> 
>  man2/prctl.2 | 331 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 331 insertions(+)
Thanks. I've pushed these changes to master now.

Cheers,

Michael



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
