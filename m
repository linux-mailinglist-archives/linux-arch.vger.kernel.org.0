Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2FB7403D0
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 21:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjF0TK0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jun 2023 15:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjF0TKZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jun 2023 15:10:25 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F334E19B5;
        Tue, 27 Jun 2023 12:10:24 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-55b1238a024so497032a12.0;
        Tue, 27 Jun 2023 12:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687893024; x=1690485024;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=yS/xmFpqe6+k8T+yWQv7frf8UxF7B6Cm+1CNfhqUPlA=;
        b=BMqSkVfZP75OxNlOqvaghKGJv9m0y4sm8KFw5SHceiXFQz/e0SiiKJT9I5B52iAH17
         cMt4KC2GjU9iq0SnaoF95JUsMa0mk+JEcq2FkRIOzoow88IvYkDfH7aBL3K5PbCOKOue
         txhLzT7BLkzfYn4DxxqSwsZ2KmDA6ILNOIWpC3UOJTW+EHWbeQQdlcmGoaBUyJofM5AY
         lnVmBNLdubBt20V6jFfi37xAvQhhTT8MryCyACblmLywm5IjXVYJCWSIUi3pbGc+j98S
         r4FtzORgbma5+HwlZ2RT9hRW9y3a8jxCdKlGNGBWvRri5+DzenA7COAJXTL5/EtGEK0g
         cong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687893024; x=1690485024;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yS/xmFpqe6+k8T+yWQv7frf8UxF7B6Cm+1CNfhqUPlA=;
        b=ekHKvHyG1UHd+o7TN7z1Melo4zGQL9XBmCjUdo0Xbe80H3zrHJpF4fc6gRCcs6TLSc
         9bUJJccpfTo0DyszmvLySNR7UBB66Yk8Odmjxl9mH9XE6Q4iHzndGCFEHLC9FooxDzMg
         Jp9OInHERAEeN4f/0cDke9ZU7ZJzA5UHzCvDKW60gIvgyCDOcPshQEiRLpxq01S229ym
         5Khb17h0H+OAokPCsSFud11ZDO84WvfzRC4qy9DqFYCu5TqHDpSxWDPLLNvSyT/lWE6A
         2aeTUZ5mBR36rhCpMnMreBZmFKmTcArvgVEOsFO5rmnXMrnu0VFwyCm14IQx187HU9uu
         N9oQ==
X-Gm-Message-State: AC+VfDwcn7DYKFo2oGwFiIQxjecW84OHG27nxgpS2wxVqEnGS4byRorD
        gkMMVfFubigQqu7xM5cB4+w=
X-Google-Smtp-Source: ACHHUZ4TyTsIrCRAZ6UdXT5Omt1I9QGIq3lGO+AmEbof8hKm4unG6pcuoo4CdZZ1APibznjic8nqlQ==
X-Received: by 2002:a17:90a:3cc6:b0:262:df8e:fcb6 with SMTP id k6-20020a17090a3cc600b00262df8efcb6mr9240150pjd.43.1687893024298;
        Tue, 27 Jun 2023 12:10:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n91-20020a17090a5ae400b002471deb13fcsm6684270pji.6.2023.06.27.12.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 12:10:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cc954b15-63ab-9d9f-2d37-1aea78b7f65f@roeck-us.net>
Date:   Tue, 27 Jun 2023 12:10:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 26/33] nios2: Convert __pte_free_tlb() to use ptdescs
Content-Language: en-US
To:     Vishal Moola <vishal.moola@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Mike Rapoport <rppt@kernel.org>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
 <20230622205745.79707-27-vishal.moola@gmail.com>
 <13bab37c-0f0a-431a-8b67-4379bf4dc541@roeck-us.net>
 <CAOzc2px6VutRkMUTn+M5LFLf1YbRVZFgJ=q7StaApwYRxUWqQA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAOzc2px6VutRkMUTn+M5LFLf1YbRVZFgJ=q7StaApwYRxUWqQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/27/23 10:42, Vishal Moola wrote:
> On Mon, Jun 26, 2023 at 10:47 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Thu, Jun 22, 2023 at 01:57:38PM -0700, Vishal Moola (Oracle) wrote:
>>> Part of the conversions to replace pgtable constructor/destructors with
>>> ptdesc equivalents.
>>>
>>> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
>>> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
>>
>> This patch causes all nios2 builds to fail.
> 
> It looks like you tried to apply this patch on its own. This patch depends
> on patches 01-12 of this patchset to compile properly. I've cross-compiled
> this architecture and it worked, but let me know if something fails
> when its applied on top of those patches (or the rest of the patchset).


No, I did not try to apply this patch on its own. I tried to build yesterday's
pending-fixes branch of linux-next.

Guenter

