Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0842E70605A
	for <lists+linux-arch@lfdr.de>; Wed, 17 May 2023 08:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjEQGnG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 02:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjEQGnE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 02:43:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7211F9;
        Tue, 16 May 2023 23:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=XJe73HNDDH/WOGpU55d+BXQ84u
        J8xryrUs1M7AwmkSDy/IywaR+lz6TY41j3I9bEZ2WfTG4W7DM3fc9fg9oo+DZ8nhs69sbRmLlo/BT
        oo5EAPTViaGhoF73TOWHuAvpJt4xVjB0Ar19vjf/5+pNbJ0cZi2OFb6U7rnHNsCPMkZGvn13dEtwE
        wHjGzC8klGkPk7sqWo1NC1Fgv7NGO3eHIr30CA3NnAV8wPulLcp4C65B763cXzJmgM3iReyyg00om
        YZDfg+EALcYAAoa6WV73AMTNrlGq1dGRhabpCK6vpyMeWfjpExyc6naeyW4ZARnbl61NtAFRVITV5
        0pb9yGiA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzAsI-008W18-1T;
        Wed, 17 May 2023 06:43:02 +0000
Date:   Tue, 16 May 2023 23:43:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, willy@infradead.org,
        deller@gmx.de
Subject: Re: [PATCH v5 RESEND 17/17] mm: ioremap: remove unneeded
 ioremap_allowed and iounmap_allowed
Message-ID: <ZGR3djHVYJuCD8I4@infradead.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-18-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515090848.833045-18-bhe@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,TVD_SUBJ_WIPE_DEBT,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
