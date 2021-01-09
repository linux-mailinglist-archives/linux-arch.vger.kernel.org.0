Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FC92EFC8A
	for <lists+linux-arch@lfdr.de>; Sat,  9 Jan 2021 02:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbhAIBBy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Jan 2021 20:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbhAIBBy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Jan 2021 20:01:54 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260EFC061573
        for <linux-arch@vger.kernel.org>; Fri,  8 Jan 2021 17:01:14 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e74so17347331ybh.19
        for <linux-arch@vger.kernel.org>; Fri, 08 Jan 2021 17:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=2kvzi9/MXTZJcB1AsjglVBP3UVDn0xJjKk3dMI1v624=;
        b=VcHiHRV/86MH0/jN9gbnzQooC4E4wtdl5zD1RupCpcLQWXK8b5I0xyvN/IjgmF0xGD
         ROzuNdi36AWzQEUpYdtSAgnomHyMrC4ViICFIFdX6WfYnIb4lHDhZMXCuwDLpG6BBZJi
         GrIAxWe7K6yYmGJ9f7LTFeYcPrxY4qcaHsuaVcI90NHK3eOS5ctTPrcRNB/xmBwwbyxo
         vNSWXw7DKHAkBRgRDl+pBAkxSm/WrZiEe9carLgI2OITduI3JdM87N2qJLCiM04sjQoP
         6Wa+TnLX1sTYpACZx/E2Z6ZcFBPkbqKjfi+nj7+9RSgT3B+0D7Z+Xi7n34LfeORUfy7A
         EkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2kvzi9/MXTZJcB1AsjglVBP3UVDn0xJjKk3dMI1v624=;
        b=Uu1rb/WkpzVFkVgOywaslp/D5QhkmVjtRM4pJATmhwSLXmvRZJLtJQuLgGRXq2MJjy
         7PTAU/t2cRHO4SuzC/JsV2dnd7ekMLCsBHxBloHPw84/OdNEA9ofT/5n+xUrbMlZ6i+x
         Axe1I185z5txE5+KcFFX6/oGdyTYS+LeSSigU25GriQs6JTX8KQWbIHDScyNb6w6Lv3O
         4256AsPQZnB4qdV7uFOM0zLibUAdHWwxOawVI6AbEY/gJaJEhPVZ6/tNVTf53isiFZFT
         UwjzFWQy1twEBTibseoDjDJl2+QJ3A5PltZkHVJmY/asRKGTgZxwShVCQ0vXsaraxiHw
         BnDg==
X-Gm-Message-State: AOAM533PYRPQMR66vorZ2R8E5zr3QjQu+6LcS9cpRzoPgA1tBtOCYRnk
        8EvAJvlP3s3sCHVgRrJFSAYCGL8dCp6KDCtf08M=
X-Google-Smtp-Source: ABdhPJyphYZARxSQ3eZ20fkLrCwLnqSq8hbl+WU+W68ygugbIhgq/OB/aVIc3g6EHxNdGi5amR2+VitHd9pf6KFOWOM=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:2d5f:: with SMTP id
 s31mr9272103ybe.90.1610154073350; Fri, 08 Jan 2021 17:01:13 -0800 (PST)
Date:   Fri,  8 Jan 2021 17:01:11 -0800
In-Reply-To: <1610099389-28329-1-git-send-email-pnagar@codeaurora.org>
Message-Id: <20210109010111.2299669-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <1610099389-28329-1-git-send-email-pnagar@codeaurora.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: Re: [RFC PATCH v2] selinux: security: Move selinux_state to a
 separate page
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     pnagar@codeaurora.org
Cc:     arnd@arndb.de, dsule@codeaurora.org, eparis@parisplace.org,
        jmorris@namei.org, joe@perches.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, jeffv@google.com,
        nmardana@codeaurora.org, ojeda@kernel.org, paul@paul-moore.com,
        psodagud@codeaurora.org, selinux@vger.kernel.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Via:
https://lore.kernel.org/lkml/1610099389-28329-1-git-send-email-pnagar@codeaurora.org/

> diff --git a/include/linux/init.h b/include/linux/init.h
> index 7b53cb3..617adcf 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -300,6 +300,10 @@ void __init parse_early_options(char *cmdline);
>  /* Data marked not to be saved by software suspend */
>  #define __nosavedata __section(".data..nosave")
>  
> +#ifdef CONFIG_SECURITY_RTIC
> +#define __rticdata  __section(".bss.rtic")

if you put:

#else
#define __rticdata

here, then you wouldn't need to label each datum you put in there.

> +#endif
> +
>  #ifdef MODULE
>  #define __exit_p(x) x
>  #else

> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -104,7 +104,11 @@
>  #include "audit.h"
>  #include "avc_ss.h"
>  
> +#ifdef CONFIG_SECURITY_RTIC
> +struct selinux_state selinux_state __rticdata;
> +#else
>  struct selinux_state selinux_state;
> +#endif

so you could then drop the if-def here.


Happy to see this resolved when building with LLD+LTO, which has been a
problem in the past.

Disabling selinux is a common attack vector on Android devices, so happy
to see some effort towards mitigation.  You might want to communicate
the feature more to existing OEMs that are using your chipsets that
support this feature.
