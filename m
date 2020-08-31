Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8F7257B4A
	for <lists+linux-arch@lfdr.de>; Mon, 31 Aug 2020 16:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgHaOaF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 10:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgHaOaF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Aug 2020 10:30:05 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4330C061573;
        Mon, 31 Aug 2020 07:30:04 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id m22so8745658eje.10;
        Mon, 31 Aug 2020 07:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GsUtzJFOnvjviCxW2IjbStQvBGLGUPcyBXj6Cdtywt8=;
        b=J6Ke5RC+m3g1nSBnNqPyMtumBUnXEruJri8HNZkz86liYmnV2q0HRxyDgJeF+6v9T9
         4n4azliF11Ez2eEObZXMmtHD0FmbHx+7N9posUPy/zlOozzyLtbSvOE+nM60IREfw7FW
         vI8Gg+dpC5KuXnXLBPmhXTFIaGsIG/vw9uq17gZ2ErjTWF89qH0PxVDrj201wh911bSK
         QQlUSKnj6SwHECIMTl8fYRlABaTQX2wDevBhlW07ycZX5nIRg8jFqJI/x/9Uvo1P3EAC
         tJ2KDKRGz7qplxNHR0+T3l4czwNFQZl2Pp3D4j7Rk71sQZxqBcsYhJIdqd69xMR/8wXp
         5UAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GsUtzJFOnvjviCxW2IjbStQvBGLGUPcyBXj6Cdtywt8=;
        b=UgszEvaSTc994HsML/7lUajcAQpTxvV+MKScjOzpvF5qi4JNVpBfwXCjkdjpxMaknf
         AjuwVutjY63+oSnjuwjuUYLiujZS2ov9vHtXu5U5mvw+IclJy+IVLWGWijZoPRRUvmBk
         zGTDSi0i3fqItnD70tSvkHC1HD9FQcZvrS/r9LLu1LGM4Tv4DpYSdOW1fov1D/p30e4c
         wq0QO6/bOIU1ecQILzLAhUM+2+Z1Qe3OOPjQ484sffBIg2rwgqGUVm03gQYpEHBjkfvr
         016TnaBPhwf9cqNbaXIfCUOfDbJAOJ6+jm9Hh2Vq+HqGcg3EZ2z/Rkzr3zCUK678gWbg
         FXeg==
X-Gm-Message-State: AOAM530L6AHIr0gch2yl1HbLYQW+eBbnUpASIlJ5kKBqAbmkNrw0HNuk
        kjbMDuQ7xVWQw1xxXZ1Faef+8YS9QWF5pLdl65A=
X-Google-Smtp-Source: ABdhPJyjPMgqhNVhFiUA4I3hTIZTzHOuaM4kG5ojHStRHxESukNTTW1UGb+Q1yubT4UmTTT2wlJTEVjFJ92AR9+xRdY=
X-Received: by 2002:a17:906:656:: with SMTP id t22mr1363085ejb.392.1598884203426;
 Mon, 31 Aug 2020 07:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200828141344.2277088-1-alinde@google.com>
In-Reply-To: <20200828141344.2277088-1-alinde@google.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Mon, 31 Aug 2020 23:29:52 +0900
Message-ID: <CAC5umyiNw7FA__Y3HZ1UEG8Y6uQDgAWHTJpOVf7okERzpCjnRg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] add fault injection to user memory access
To:     albert.linde@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, bp@alien8.de,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>, glider@google.com,
        andreyknvl@google.com, Dmitry Vyukov <dvyukov@google.com>,
        elver@google.com, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>, x86@kernel.org,
        Albert van der Linde <alinde@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

2020=E5=B9=B48=E6=9C=8828=E6=97=A5(=E9=87=91) 23:14 <albert.linde@gmail.com=
>:
>
> From: Albert van der Linde <alinde@google.com>
>
> The goal of this series is to improve testing of fault-tolerance in
> usages of user memory access functions, by adding support for fault
> injection.
>
> The first patch adds failure injection capability for usercopy
> functions. The second changes usercopy functions to use this new failure
> capability (copy_from_user, ...). The third patch adds
> get/put/clear_user failures to x86.

This series looks good to me.

Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>
