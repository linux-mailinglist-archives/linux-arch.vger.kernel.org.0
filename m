Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2996933CAD9
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 02:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhCPBUs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Mar 2021 21:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhCPBUQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Mar 2021 21:20:16 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A103C06174A
        for <linux-arch@vger.kernel.org>; Mon, 15 Mar 2021 18:20:15 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id e2so10910789pld.9
        for <linux-arch@vger.kernel.org>; Mon, 15 Mar 2021 18:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:to:cc:subject:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=lllSVlP83Zm5w8UR9KXH+eISNqCBApxi8VdWF12ub40=;
        b=gFWKzN3reXHAX5ObzOjhJ7RyCpBNzpMnVx+OPPAadiry+RmijAe840mbs2p1JUF67+
         bxOyjMMJJj2zh6yMQ8RTY8pp5JOWPEi64qKz3/wYmWZrIi46sdqIpixS9Yk+NP+07TGI
         X4EZAhqZxJobz/JW3ZNaD3EZxppgw8UCyOY3c9lsNP3X+qAlK7LBuBlIFcMng65u7aeD
         o9UkTv4SScQyxV4uin9/XE9eGB2qIUtqp61jDKfDHIXk0zgMrGlesee50VV2byUdTHmi
         +Gg/4rxUoFrO1rWi+0a4UrYu5IMzlkJ59QhqfxbB4KpnHpoTZdGoBeYxvhJcYuxnoha0
         dxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:to:cc:subject:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=lllSVlP83Zm5w8UR9KXH+eISNqCBApxi8VdWF12ub40=;
        b=VVYcegtwwEN2xMm3iDafXejlXnhzV+DsTcGSZFz3uwtu0x1Dn91FtVS9uQqFTgsaGd
         TIsUISuWgBiw3s+0eHkqOXir5cShyyzvWZ+gjijAnYQ/kbjCAgg9f30jySx6Kr0R7olI
         h2CxRwgGpvu0iM0e2I51PiRg/K5roA8S3iiZuKoT622hKyG0+UOFuraLY/J2HaL9U/aK
         DlYSnYB8/qKTfFH+ayuoHCisJjD3nDJe0y6+P3Fyop7hAWNO3+tHAQMPgTeOXXt3m+wv
         kOHoWg80G2A0VQDkwy44yn1su4wC1Qlahoh2AGMitFb1iVzzTe1x10qLtZF9XNYYNCJG
         wxPA==
X-Gm-Message-State: AOAM5314jHqEmYgeOD/TPC22wB5K2lUQUI17W0i4El2jio4pk2bwXnTt
        c8VWpjpVHtUX4rFuYyv2KjA=
X-Google-Smtp-Source: ABdhPJwcAgrufyKafN+gWXC7R0nTZsc/AgWLL9N3J+gLOt4amYKTaxjTxTVpynIRcDKysNsJud3Ksg==
X-Received: by 2002:a17:902:8bcb:b029:e6:a4a1:9d7e with SMTP id r11-20020a1709028bcbb02900e6a4a19d7emr11170380plo.25.1615857614647;
        Mon, 15 Mar 2021 18:20:14 -0700 (PDT)
Received: from sun.local.gmail.com (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id z25sm14368515pfn.37.2021.03.15.18.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 18:20:14 -0700 (PDT)
Date:   Tue, 16 Mar 2021 10:20:13 +0900
Message-ID: <m21rcfc2sy.wl-thehajime@gmail.com>
From:   Hajime Tazaki <thehajime@gmail.com>
To:     johannes@sipsolutions.net
Cc:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, tavi.purdila@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        retrage01@gmail.com
Subject: Re: [RFC v8 13/20] um: lkl: integrate with irq infrastructure of UML
In-Reply-To: <5e1f64997ffca8267bde7955fe2eb214dfb9e891.camel@sipsolutions.net>
References: <cover.1611103406.git.thehajime@gmail.com>
        <46935454bf02224fb325f0e74d60d0ed674a59f9.1611103406.git.thehajime@gmail.com>
        <5e1f64997ffca8267bde7955fe2eb214dfb9e891.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.1 Mule/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Mon, 15 Mar 2021 05:45:23 +0900,
Johannes Berg wrote:
>=20
> On Wed, 2021-01-20 at 11:27 +0900, Hajime Tazaki wrote:
> > =A0static irqreturn_t um_timer(int irq, void *dev)
> > =A0{
> > +#ifndef CONFIG_UMMODE_LIB
> > =A0	if (get_current()->mm !=3D NULL)
>=20
> Why is the ifdef needed - get_current()->mm should always be NULL for
> LKL? Surely get_current() must still work?

What we tried to ifdef is to avoid the following call;

   os_alarm_process(get_current()->mm->context.id.u.pid);

because we didn't use/update get_current()->mm->context.id (struct
mm_id) and calling kill(0, SIGALRM) makes a program puzzled thus,
eliminate it.

> > =A0	sigemptyset(&sig_mask);
> > =A0	sigaddset(&sig_mask, sig);
> > -	if (sigprocmask(SIG_UNBLOCK, &sig_mask, NULL) < 0)
> > -		panic("sigprocmask failed - errno =3D %d\n", errno);
> > +	if (pthread_sigmask(SIG_UNBLOCK, &sig_mask, NULL) < 0)
> > +		panic("pthread_sigmask failed - errno =3D %d\n", errno);
>=20
> UML doesn't normally link with libpthread, and LKL doesn't actually
> appear to require it either (since it has its lkl_thread and all), so
> this seems wrong?

I think both UML/LKL link with libpthread.  See old
scripts/link-vmlinux.sh, or [01/20] patch.

-		${CC} ${CFLAGS_vmlinux}				\
-			${strip_debug}				\
-			-o ${output}				\
-			-Wl,-T,${lds}				\
-			${objects}				\
-			-lutil -lrt -lpthread
-		rm -f linux

-- Hajime
