Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E359230C4F
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 16:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbgG1OXI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jul 2020 10:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730008AbgG1OXH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jul 2020 10:23:07 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8BCC0619D2
        for <linux-arch@vger.kernel.org>; Tue, 28 Jul 2020 07:23:07 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id c6so5067091pje.1
        for <linux-arch@vger.kernel.org>; Tue, 28 Jul 2020 07:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=0gezrYAszKsYKcLXi9TMmF45AfpArZp7tf2tQTcsIB4=;
        b=D7/86MC1Tqp9oc0VICIhfafxb3tBKrlVgTQgo74JcMWGNVZjzmkRkSPO+UaELTUEwa
         hA2GW+HERh5M2odXF3L1QZNAFFoTOnxCUqDuUqd+xD54MgRqydkWiLasAWQmucuiUX9y
         /HA6vqfiAYDwCMBvJQPsnzD96xliQ3O0e++hOjll/2Z5APzOuNu7gH9zfRs4jk1u/4VI
         49V7Y+MZGeI3h+zO6gZkKACbWgKi3SBDGtM0OP0OKRBoHDlHCLafa/fTo8q2s2AnY2mL
         fhpECbWQwe8VhAil1beOIe84mykJJtKhpx/KmcnDNs3QlX6d51VI87/q+vivCNN/VjqH
         7mig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=0gezrYAszKsYKcLXi9TMmF45AfpArZp7tf2tQTcsIB4=;
        b=YGBN8PJqrVCITlqDMzhAu2qP94+RkERbELh8xmvPB3VTms1+Q9TUKscfGXwHFsEJsA
         7oPpdNckEV+0TDFpsXuXry8ejFN/7vFiFRSQTDyGZhiMCRpPSOKzW1DzZ1C47IwZW0Kr
         aS30rJ3TjvPQeVfVP+ga79F2rGvo/vDVzeSMHEz9vj8esmszdDwRtS8f6F/bMZWAyO1B
         gl0vIdefQNaVRYmaCeOtmb94WD/ED++H6qmjVL0Z8tFqUq0krJTq1Nd9xrGK72Jo79wv
         3d/oki1uxujWNcrXLzCnG4xxjJ8xAmtZydhREh4pazw4kjbiOU6LBvVlS0sKlaKZ1/bq
         3qQA==
X-Gm-Message-State: AOAM533MyA88LDnGtmdIsAybWeM1w1rC++lsdnGGQ7jzwOFnnTRAsUcV
        axwdi+CQX67SUCsGW4gt09w3AQ==
X-Google-Smtp-Source: ABdhPJwGmlsbEVuJXdrA5FyCMv/IW/fPnSTAHwkj6VyQa14OnWq1IW5Sje+yw0TWIJZrFoMkdQtvhw==
X-Received: by 2002:a17:90a:ce0c:: with SMTP id f12mr4957417pju.19.1595946186974;
        Tue, 28 Jul 2020 07:23:06 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:1c3a:e74b:bd16:b3ab? ([2601:646:c200:1ef2:1c3a:e74b:bd16:b3ab])
        by smtp.gmail.com with ESMTPSA id 4sm18047374pgk.68.2020.07.28.07.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 07:23:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Date:   Tue, 28 Jul 2020 07:23:03 -0700
Message-Id: <1764B08C-CC1E-4636-944A-DB95B81C7A8E@amacapital.net>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        gerg@linux-m68k.org, ktkhai@virtuozzo.com,
        christian.brauner@ubuntu.com, peterz@infradead.org,
        esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me,
        areber@redhat.com, cyphar@cyphar.com, steven.sistare@oracle.com
In-Reply-To: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
To:     Anthony Yznaga <anthony.yznaga@oracle.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Jul 27, 2020, at 10:02 AM, Anthony Yznaga <anthony.yznaga@oracle.com> w=
rote:
>=20
> =EF=BB=BFThis patchset adds support for preserving an anonymous memory ran=
ge across
> exec(3) using a new madvise MADV_DOEXEC argument.  The primary benefit for=

> sharing memory in this manner, as opposed to re-attaching to a named share=
d
> memory segment, is to ensure it is mapped at the same virtual address in
> the new process as it was in the old one.  An intended use for this is to
> preserve guest memory for guests using vfio while qemu exec's an updated
> version of itself.  By ensuring the memory is preserved at a fixed address=
,
> vfio mappings and their associated kernel data structures can remain valid=
.
> In addition, for the qemu use case, qemu instances that back guest RAM wit=
h
> anonymous memory can be updated.

This will be an amazing attack surface. Perhaps use of this flag should requ=
ire no_new_privs?  Arguably it should also require a special flag to execve(=
) to honor it.  Otherwise library helpers that do vfork()+exec() or posix_sp=
awn() could be quite surprised.

