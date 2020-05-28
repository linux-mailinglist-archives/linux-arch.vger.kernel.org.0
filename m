Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26981E573B
	for <lists+linux-arch@lfdr.de>; Thu, 28 May 2020 08:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgE1GFJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 May 2020 02:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbgE1GFI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 May 2020 02:05:08 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA6AC05BD1E;
        Wed, 27 May 2020 23:05:07 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id y13so8767629eju.2;
        Wed, 27 May 2020 23:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gr2QJjfQwZw9TOoef9/CtZwlj2xaVVZ2MosCnhi+D4Y=;
        b=uT664BfCKD11g59N8NxYNnQAplKNgks3tcQJtPsg7EMK8v+bHKLWEx+us61PDVoIEF
         Etojnh0KAUk3Dq74XioSiL2SIkDcVQ+r6Rkyyvux71cTcPX3s1pUMcrqZoRwaanfkGHv
         t2PCfR6IovtThJ5/d29Kw3XIRWcd+gcesYcP1jsxf6lxI3y/CuVMVYWxxedyuqzRixZJ
         HNIMCiPmwjFwo78VSSDRn8+VRvoUBBD1qmpniDXb1FUt8U58R+5uDnH0Za+/3aWCUw+x
         +kufOH7t5VY7XVfBrlZ6rMBI6a2gdAW7ZOzjAN7I+4McB4v8L6QP3+kiJ/mKcMNOiI4a
         0QWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gr2QJjfQwZw9TOoef9/CtZwlj2xaVVZ2MosCnhi+D4Y=;
        b=CxCOCN/vkEJg5A4kQq+IuRWIDSataCtoEknESP1oEaLTon8rLg7vsIbaH8mUZqxvaz
         ul+uTc7MBZ8IJq4mJ8oS4P5WOi+BwHSbfxTy1x2VhAypOTcUaGvqHsP5SHCuSb4spXv4
         H1+zyfSnhoUl94TzpaQpWYzX4C78g72F77ORCuYCfkwNCTibXGkPGzAKsZvSsMDk/z5m
         P0MCcbgDTq9SPsOX0e/xEsWQM341duUU9VtKl8zMy1fk6LrQBSp8o6zY/YsjGHQpSSIg
         SMcPJGhLkK7dtSUXlrM8rTy3GnFMDJeNgQPajgVV6qGXQIjLWjGlHbm5kgawORX58sWB
         J51g==
X-Gm-Message-State: AOAM5334yCp0vQRZPjGKwPBHprEhGhM8nkgFcVZjPyJk06iguBq0uMyh
        sNPv466T5hnBod9p1x75oXagv5B6ynY=
X-Google-Smtp-Source: ABdhPJxjVLMKxzwXsFiCP+cJ7nLEssCwZug0h9DUfmwi6L1qHjlZIWcNchUGODktXsRFZRS6d4H40Q==
X-Received: by 2002:a17:906:4088:: with SMTP id u8mr1634002ejj.422.1590645905844;
        Wed, 27 May 2020 23:05:05 -0700 (PDT)
Received: from ?IPv6:2001:a61:2516:6501:a84b:ccd6:785a:2f0f? ([2001:a61:2516:6501:a84b:ccd6:785a:2f0f])
        by smtp.gmail.com with ESMTPSA id nw22sm4561913ejb.48.2020.05.27.23.05.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 23:05:05 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/6] prctl.2: ffix use literal hyphens when referencing
 kernel docs
To:     Dave Martin <Dave.Martin@arm.com>
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
 <1590614258-24728-2-git-send-email-Dave.Martin@arm.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <43a7fb5b-7626-0f05-a13f-a4d35eb3289f@gmail.com>
Date:   Thu, 28 May 2020 08:05:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1590614258-24728-2-git-send-email-Dave.Martin@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/27/20 11:17 PM, Dave Martin wrote:
> There is one case of a cross-reference to a kernel documentation
> filename that uses unescaped hyphens.
> 
> To avoid misrendering, escape these as \- similarly to other
> instances.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  man2/prctl.2 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index 968a75a..dc99218 100644
> --- a/man2/prctl.2
> +++ b/man2/prctl.2
> @@ -1261,7 +1261,7 @@ This parameter may enforce a read-only policy which will result in the
>  call failing with the error
>  .BR ENXIO .
>  For further details, see the kernel source file
> -.IR Documentation/admin-guide/kernel-parameters.txt .
> +.IR Documentation/admin\-guide/kernel\-parameters.txt .
>  .\"
>  .\" prctl PR_TASK_PERF_EVENTS_DISABLE
>  .TP

Thanks, Dave. Applied.

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
