Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1DB2EF4C6
	for <lists+linux-arch@lfdr.de>; Fri,  8 Jan 2021 16:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbhAHP0d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Jan 2021 10:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbhAHP0d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Jan 2021 10:26:33 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B82C061380;
        Fri,  8 Jan 2021 07:25:52 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id x2so9657905ybt.11;
        Fri, 08 Jan 2021 07:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=juapD2gtXExys3xTOoCmR/j5jceLJmjFhmJC+0q/QLc=;
        b=RRtwjoIZsFWg2U+BKYYiija5PT1VcgximBT5SGO95WAYb92Jvxv8+/WvCaKgEdBESA
         cdtt8MZvSelYKjQCIuuzi0GBe1V7usPmkADrAsjiqv3g1Lwz+TnXBHXdOJtpROUk3A3K
         IbL0DCvQYtd+GD8tla7gOA1wJEJnhr7ZvzpVhykH88efwWFQc4C3Em6cPUSSETdhyRIN
         ugBxD7R4xjKwDPgETz7W7CuCMIKlpJflQ12rJnprWh3DCHNB65ZOuGWZcv9dZ8RjVOQO
         3wLq0gyt1ka/XnN3RO/6n76O1reEIjj5gR0CdD2oK/3C4oNZe7Dc3rQEYvmIHiCCUiBW
         LHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=juapD2gtXExys3xTOoCmR/j5jceLJmjFhmJC+0q/QLc=;
        b=Z+LK8T+UQM+SuaGtPyeV01Fu8P4TYAW2IjCypcLEVQDcR3WCBCDmlWwM8zF2eR1l7I
         1n6Zj9HrtOlS6nvI9sYZSWphOq/ETY01rdXP7MXTtxApwcvKPjXydkTYbkoa4RarGoRS
         ujSHaXrIlXnyZ/Z2POGWWZ+YhWUI+GviPQjnOoGS/zgQOGtzhjt8VIiiUK3TlAYfxlT+
         BpML4rMhJnoxYAX83VO9aU0Xwt+DpAd5V34d5FtCs+SGf/xYmQU1g9tOduyTyMbVyI/G
         SS4YG95m6preK5VbE66+tDK+iHMIcKgWTvl/lfFZM24aU7r8DasO/z5voeMqIZVxijYM
         HbDg==
X-Gm-Message-State: AOAM532xdLQxDLCbHOp97zOkD2IhY5lJYt9anNWyeFgKg1MDrYjWO2Ri
        2e4oLJmkoKIX23QE7bgrq3xSDe8wWK3qo6HaoEQ=
X-Google-Smtp-Source: ABdhPJzCcjH5HbBDMuYcsN+w+ydFlIO0VWc9zAfr0hfjXlE627jkbTSmTtMW94GclQrGSLZtzZgoneWgNpQFdlZth88=
X-Received: by 2002:a25:40d:: with SMTP id 13mr6631073ybe.422.1610119552284;
 Fri, 08 Jan 2021 07:25:52 -0800 (PST)
MIME-Version: 1.0
References: <1610099389-28329-1-git-send-email-pnagar@codeaurora.org>
In-Reply-To: <1610099389-28329-1-git-send-email-pnagar@codeaurora.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 8 Jan 2021 16:25:41 +0100
Message-ID: <CANiq72=y7gapKpVKFwu30jDpv4qswgo5K3+u5QMOY4dtacKX=Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2] selinux: security: Move selinux_state to a
 separate page
To:     Preeti Nagar <pnagar@codeaurora.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, jmorris@namei.org, serge@hallyn.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>,
        psodagud@codeaurora.org, nmardana@codeaurora.org,
        dsule@codeaurora.org, Joe Perches <joe@perches.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 8, 2021 at 10:52 AM Preeti Nagar <pnagar@codeaurora.org> wrote:
>
> We want to seek your suggestions and comments on the idea and the changes
> in the patch.

Not sure why I was Cc'd, but I have a quick comment nevertheless.

> +#ifdef CONFIG_SECURITY_RTIC
> +struct selinux_state selinux_state __rticdata;
> +#else
>  struct selinux_state selinux_state;
> +#endif

If you define an empty __rticdata for the !CONFIG case, then we don't
need #ifdefs for uses like this.

Cheers,
Miguel
