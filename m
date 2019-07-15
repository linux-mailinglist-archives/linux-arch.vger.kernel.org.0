Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42E096916D
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jul 2019 16:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391553AbfGOO3U (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Jul 2019 10:29:20 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45849 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391544AbfGOO3T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jul 2019 10:29:19 -0400
Received: by mail-ot1-f66.google.com with SMTP id x21so17145516otq.12
        for <linux-arch@vger.kernel.org>; Mon, 15 Jul 2019 07:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6QkSbJ8pehcPJsEqSW/0Jw3Kj7WtEh8gEc9PVJH1CrA=;
        b=YDX5Cni69En7Hnte+J3OlCSJ0HlBPkTtUerLm+TEt90UKpDUfDuJvjCxyA/xsbdN+4
         NlM28WRfcpu6byVaPN4oE7VH4s3k0vd1hEb+a57aabIHxBzldliL2Htoq2btKjK4n7AS
         dEk3INMwrusBqXJOHjVd5y+1ZYzs3lAeIPfrwgpru+b49OUDLgXf6+CpcsZ6fG8itG0F
         1l0rPwOFa7qBIOGncKcrTTI0b32v3jNfOV6b+s6CSQAQGdFNyL4RrykbWCb0WlSmG84g
         rPg2y0ELpTG/hNU8ek2ztwI6ffWkYO0HuhjiHpT2javBLichO07Q+0RuqzlaxnSebk5a
         7e7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6QkSbJ8pehcPJsEqSW/0Jw3Kj7WtEh8gEc9PVJH1CrA=;
        b=cCcHjrcPYDiaR0ohDcrteovV9Ib7nmqqirKMHrHuW5B2jPifghvFDIR9/mw6EkJOYi
         XHHxLHl9/7d1EhJugSS2Awy1/kbRUb+uS/tbRtvfOzxGxDNP68fR8WIa4W/6CVyqdYCy
         vOMkYlQX2L/t0X2ta9y4I8nKcsfOTPBBXM73UjW4qXro7y20myLMvcs4ge/marjfMPZG
         YvMYakI5fLEdZ0747D7g2lbVbdGBKodhHv0gBnckGPepg19sCe0ImGz9nfpGAmNZCoOG
         6dMP3ZGAcKcHVsdmoEsae630V5KAQHnur5iYq4S399HKoP/G8uDyI58u1aBRtDjUOFkw
         8cew==
X-Gm-Message-State: APjAAAW/S0C73kpWLM2expEqIMZqJSegZDRLIn66b+6eSP02rCeCcp9+
        aSqDCfhhHTbim0YFi4Aw3tE=
X-Google-Smtp-Source: APXvYqyjL0Ot/+YneSRjZE4d+NlwotmvVCLCkSyihKbIEGxxfUrBUzxa4ggVFEdDWrNvLtFCu+w3cQ==
X-Received: by 2002:a05:6830:193:: with SMTP id q19mr20811013ota.187.1563200957973;
        Mon, 15 Jul 2019 07:29:17 -0700 (PDT)
Received: from brauner.io ([208.54.86.135])
        by smtp.gmail.com with ESMTPSA id a94sm6577090otb.15.2019.07.15.07.29.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 07:29:16 -0700 (PDT)
Date:   Mon, 15 Jul 2019 16:29:09 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 1/2] arch: mark syscall number 435 reserved for clone3
Message-ID: <20190715142907.7p43dgmx5sz5oouz@brauner.io>
References: <20190714192205.27190-1-christian@brauner.io>
 <20190714192205.27190-2-christian@brauner.io>
 <e14eb2f9-43cb-0b9d-dec4-b7e7dcd62091@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e14eb2f9-43cb-0b9d-dec4-b7e7dcd62091@de.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 15, 2019 at 03:56:04PM +0200, Christian Borntraeger wrote:
> I think Vasily already has a clone3 patch for s390x with 435. 

Excellent. I'll leave the # 435 reserved for clone3 on s390x in until
this patch has landed. It shouldn't be a merge conflict and if so it
should be trivial.

Christian
