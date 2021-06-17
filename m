Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1F13ABE52
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jun 2021 23:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhFQVqA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Jun 2021 17:46:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40554 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229842AbhFQVp7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 17 Jun 2021 17:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623966230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MlLxBerkc0wbd/PrLv0vX1VgkFRCc2je/OciFMlOjyA=;
        b=Ze/gvG/9mY+X3xJ8nOKIbTSqB+w1m0hPy0I6tduiOZyUq01WLIENK1kSAzB8kBasI32G0w
        Oh3TM4gjqkC/+4tFbs659yOj24omgTvfs7KVcwwQsBP5gcOVrjHaqaGmgyF2ugQ4OxJpSl
        3g9fropOiotq2CU6mwkGclawV/LVQtA=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-GQNcQQtnOMG1bIh7Ug2ADA-1; Thu, 17 Jun 2021 17:43:49 -0400
X-MC-Unique: GQNcQQtnOMG1bIh7Ug2ADA-1
Received: by mail-oi1-f198.google.com with SMTP id v142-20020acaac940000b02901f80189ca30so3671280oie.22
        for <linux-arch@vger.kernel.org>; Thu, 17 Jun 2021 14:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MlLxBerkc0wbd/PrLv0vX1VgkFRCc2je/OciFMlOjyA=;
        b=nlQlsXwVjcBRNPnaj2H88XGkMCYtzU0PR5oM31/QZi3Yc+XxhvumS7Ju+dags2dBht
         PlXOgwfBwppmNxpMBIeY5vgzJJdoe+JdZVhb3Sea021Vf4e3jZ+Pj1uaVoFMG/MFlxHf
         afAqnn4u5/YbCm5nTp3KRoTF96tiSbBjg4Wx7XujhXdQpuvOhn+zfokY3nLOCXpXNKGf
         SqZtldCfdgMPffrpKci2xXqDuBLpD3na341TgcJ/18YqBox/H9g4BWT5z71mDShk4UgX
         7nAY8BUge1kHKZloH8OOly1P6FhEtmU2tsLgqqBqiOM9AyqltBxAHGaspLawJO7+3MVV
         ksSg==
X-Gm-Message-State: AOAM531Jc1ReCx5FoXvunVpbq5knu2ERnRL33CHoewZSe/dq/W7wBVM0
        FkTS9IZG/Hy9XpXvDuJO8vBqhpDVhpArvg4kOpAmrdv1zinkMu+WhCtqn1aT8nvQkYOhK6cMPpx
        ikUn6M6kYP66hSsHbOTmHEg==
X-Received: by 2002:a05:6830:457:: with SMTP id d23mr6421839otc.64.1623966228053;
        Thu, 17 Jun 2021 14:43:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGayZam6nkZ0qX2VuWDLBn+si2kfPLo3x2dTs1url8XI6YXfGZrEJCga9jX4cKZEscVvGfEw==
X-Received: by 2002:a05:6830:457:: with SMTP id d23mr6421828otc.64.1623966227830;
        Thu, 17 Jun 2021 14:43:47 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 15sm1366313oij.26.2021.06.17.14.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 14:43:47 -0700 (PDT)
From:   trix@redhat.com
To:     arnd@arndb.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 0/1] bug: mark generic BUG() as unreachable
Date:   Thu, 17 Jun 2021 14:43:26 -0700
Message-Id: <20210617214328.3501174-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tom Rix <trix@redhat.com>

This is a followup patch discussed here
https://lore.kernel.org/lkml/162375813191.653958.11993495571264748407.stgit@warthog.procyon.org.uk/

Arches that defined BUG() were reviewed either by inspection or
by cross building the fs/afs/dir.c reproducer, all lotm.

There was no change to the assembly for the ppc64 reproducer.

Tom Rix (1):
  bug: mark generic BUG() as unreachable

 include/asm-generic/bug.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.26.3

