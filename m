Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D897217C70
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jul 2020 03:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgGHBHv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Jul 2020 21:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728201AbgGHBHv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jul 2020 21:07:51 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47A2C061755;
        Tue,  7 Jul 2020 18:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=8jRIBWNGy9c23iQpeE8DZq/0IPw8iKPvSlGvT8kQI/0=; b=3J9j+ybyT+35mMAArGGUSn3lRI
        vwAHeUnsbN55FIlN+9qayxSF9ynJ+SL6i/gnQ+zGzUetsnYmp82ULB7AMWoa6jj17DjNfscGTuGTw
        TqUfwIM3XRuAzZjZPMC57qcmjgO64az0vDMn5PaMs9ISzOdaC5V5dvGdHlqD9r2TLAEw3gYIHn7TT
        3L0vPAvWCn7ydR7NKFA0J0EiV+X/qpBqDXvA41leLcVjyZMtpeeMQq6v3G8nRxm8i15Pj4kHaEq50
        SL5TqcpS/fiFVgvHGpMoL5oqESl0FlqNi7hq0nD3tDALu5CYnR+IAiVsv+i2u2OXnHCmE45jg7b6N
        5edU40hw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsyYt-0000MT-CS; Wed, 08 Jul 2020 01:07:48 +0000
To:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] Documentation/vm: fix tables in arch_pgtable_helpers
Message-ID: <02ee60d0-e836-2237-4881-5c57ccac5551@infradead.org>
Date:   Tue, 7 Jul 2020 18:07:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Make the tables be presented as tables in the generated output files
(the line drawing did not present well).

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 Documentation/vm/arch_pgtable_helpers.rst |  333 ++++++--------------
 1 file changed, 116 insertions(+), 217 deletions(-)

--- linux-next-20200707.orig/Documentation/vm/arch_pgtable_helpers.rst
+++ linux-next-20200707/Documentation/vm/arch_pgtable_helpers.rst
@@ -17,242 +17,141 @@ test need to be in sync.
 PTE Page Table Helpers
 ======================
 
---------------------------------------------------------------------------------
-| pte_same                  | Tests whether both PTE entries are the same      |
---------------------------------------------------------------------------------
-| pte_bad                   | Tests a non-table mapped PTE                     |
---------------------------------------------------------------------------------
-| pte_present               | Tests a valid mapped PTE                         |
---------------------------------------------------------------------------------
-| pte_young                 | Tests a young PTE                                |
---------------------------------------------------------------------------------
-| pte_dirty                 | Tests a dirty PTE                                |
---------------------------------------------------------------------------------
-| pte_write                 | Tests a writable PTE                             |
---------------------------------------------------------------------------------
-| pte_special               | Tests a special PTE                              |
---------------------------------------------------------------------------------
-| pte_protnone              | Tests a PROT_NONE PTE                            |
---------------------------------------------------------------------------------
-| pte_devmap                | Tests a ZONE_DEVICE mapped PTE                   |
---------------------------------------------------------------------------------
-| pte_soft_dirty            | Tests a soft dirty PTE                           |
---------------------------------------------------------------------------------
-| pte_swp_soft_dirty        | Tests a soft dirty swapped PTE                   |
---------------------------------------------------------------------------------
-| pte_mkyoung               | Creates a young PTE                              |
---------------------------------------------------------------------------------
-| pte_mkold                 | Creates an old PTE                               |
---------------------------------------------------------------------------------
-| pte_mkdirty               | Creates a dirty PTE                              |
---------------------------------------------------------------------------------
-| pte_mkclean               | Creates a clean PTE                              |
---------------------------------------------------------------------------------
-| pte_mkwrite               | Creates a writable PTE                           |
---------------------------------------------------------------------------------
-| pte_mkwrprotect           | Creates a write protected PTE                    |
---------------------------------------------------------------------------------
-| pte_mkspecial             | Creates a special PTE                            |
---------------------------------------------------------------------------------
-| pte_mkdevmap              | Creates a ZONE_DEVICE mapped PTE                 |
---------------------------------------------------------------------------------
-| pte_mksoft_dirty          | Creates a soft dirty PTE                         |
---------------------------------------------------------------------------------
-| pte_clear_soft_dirty      | Clears a soft dirty PTE                          |
---------------------------------------------------------------------------------
-| pte_swp_mksoft_dirty      | Creates a soft dirty swapped PTE                 |
---------------------------------------------------------------------------------
-| pte_swp_clear_soft_dirty  | Clears a soft dirty swapped PTE                  |
---------------------------------------------------------------------------------
-| pte_mknotpresent          | Invalidates a mapped PTE                         |
---------------------------------------------------------------------------------
-| ptep_get_and_clear        | Clears a PTE                                     |
---------------------------------------------------------------------------------
-| ptep_get_and_clear_full   | Clears a PTE                                     |
---------------------------------------------------------------------------------
-| ptep_test_and_clear_young | Clears young from a PTE                          |
---------------------------------------------------------------------------------
-| ptep_set_wrprotect        | Converts into a write protected PTE              |
---------------------------------------------------------------------------------
-| ptep_set_access_flags     | Converts into a more permissive PTE              |
---------------------------------------------------------------------------------
+===========================   ================================================
+pte_same                      Tests whether both PTE entries are the same
+pte_bad                       Tests a non-table mapped PTE
+pte_present                   Tests a valid mapped PTE
+pte_young                     Tests a young PTE
+pte_dirty                     Tests a dirty PTE
+pte_write                     Tests a writable PTE
+pte_special                   Tests a special PTE
+pte_protnone                  Tests a PROT_NONE PTE
+pte_devmap                    Tests a ZONE_DEVICE mapped PTE
+pte_soft_dirty                Tests a soft dirty PTE
+pte_swp_soft_dirty            Tests a soft dirty swapped PTE
+pte_mkyoung                   Creates a young PTE
+pte_mkold                     Creates an old PTE
+pte_mkdirty                   Creates a dirty PTE
+pte_mkclean                   Creates a clean PTE
+pte_mkwrite                   Creates a writable PTE
+pte_mkwrprotect               Creates a write protected PTE
+pte_mkspecial                 Creates a special PTE
+pte_mkdevmap                  Creates a ZONE_DEVICE mapped PTE
+pte_mksoft_dirty              Creates a soft dirty PTE
+pte_clear_soft_dirty          Clears a soft dirty PTE
+pte_swp_mksoft_dirty          Creates a soft dirty swapped PTE
+pte_swp_clear_soft_dirty      Clears a soft dirty swapped PTE
+pte_mknotpresent              Invalidates a mapped PTE
+ptep_get_and_clear            Clears a PTE
+ptep_get_and_clear_full       Clears a PTE
+ptep_test_and_clear_young     Clears young from a PTE
+ptep_set_wrprotect            Converts into a write protected PTE
+ptep_set_access_flags         Converts into a more permissive PTE
+===========================   ================================================
 
 ======================
 PMD Page Table Helpers
 ======================
 
---------------------------------------------------------------------------------
-| pmd_same                  | Tests whether both PMD entries are the same      |
---------------------------------------------------------------------------------
-| pmd_bad                   | Tests a non-table mapped PMD                     |
---------------------------------------------------------------------------------
-| pmd_leaf                  | Tests a leaf mapped PMD                          |
---------------------------------------------------------------------------------
-| pmd_huge                  | Tests a HugeTLB mapped PMD                       |
---------------------------------------------------------------------------------
-| pmd_trans_huge            | Tests a Transparent Huge Page (THP) at PMD       |
---------------------------------------------------------------------------------
-| pmd_present               | Tests a valid mapped PMD                         |
---------------------------------------------------------------------------------
-| pmd_young                 | Tests a young PMD                                |
---------------------------------------------------------------------------------
-| pmd_dirty                 | Tests a dirty PMD                                |
---------------------------------------------------------------------------------
-| pmd_write                 | Tests a writable PMD                             |
---------------------------------------------------------------------------------
-| pmd_special               | Tests a special PMD                              |
---------------------------------------------------------------------------------
-| pmd_protnone              | Tests a PROT_NONE PMD                            |
---------------------------------------------------------------------------------
-| pmd_devmap                | Tests a ZONE_DEVICE mapped PMD                   |
---------------------------------------------------------------------------------
-| pmd_soft_dirty            | Tests a soft dirty PMD                           |
---------------------------------------------------------------------------------
-| pmd_swp_soft_dirty        | Tests a soft dirty swapped PMD                   |
---------------------------------------------------------------------------------
-| pmd_mkyoung               | Creates a young PMD                              |
---------------------------------------------------------------------------------
-| pmd_mkold                 | Creates an old PMD                               |
---------------------------------------------------------------------------------
-| pmd_mkdirty               | Creates a dirty PMD                              |
---------------------------------------------------------------------------------
-| pmd_mkclean               | Creates a clean PMD                              |
---------------------------------------------------------------------------------
-| pmd_mkwrite               | Creates a writable PMD                           |
---------------------------------------------------------------------------------
-| pmd_mkwrprotect           | Creates a write protected PMD                    |
---------------------------------------------------------------------------------
-| pmd_mkspecial             | Creates a special PMD                            |
---------------------------------------------------------------------------------
-| pmd_mkdevmap              | Creates a ZONE_DEVICE mapped PMD                 |
---------------------------------------------------------------------------------
-| pmd_mksoft_dirty          | Creates a soft dirty PMD                         |
---------------------------------------------------------------------------------
-| pmd_clear_soft_dirty      | Clears a soft dirty PMD                          |
---------------------------------------------------------------------------------
-| pmd_swp_mksoft_dirty      | Creates a soft dirty swapped PMD                 |
---------------------------------------------------------------------------------
-| pmd_swp_clear_soft_dirty  | Clears a soft dirty swapped PMD                  |
---------------------------------------------------------------------------------
-| pmd_mkinvalid             | Invalidates a mapped PMD [1]                     |
---------------------------------------------------------------------------------
-| pmd_set_huge              | Creates a PMD huge mapping                       |
---------------------------------------------------------------------------------
-| pmd_clear_huge            | Clears a PMD huge mapping                        |
---------------------------------------------------------------------------------
-| pmdp_get_and_clear        | Clears a PMD                                     |
---------------------------------------------------------------------------------
-| pmdp_get_and_clear_full   | Clears a PMD                                     |
---------------------------------------------------------------------------------
-| pmdp_test_and_clear_young | Clears young from a PMD                          |
---------------------------------------------------------------------------------
-| pmdp_set_wrprotect        | Converts into a write protected PMD              |
---------------------------------------------------------------------------------
-| pmdp_set_access_flags     | Converts into a more permissive PMD              |
---------------------------------------------------------------------------------
+===========================   ================================================
+pmd_same                      Tests whether both PMD entries are the same
+pmd_bad                       Tests a non-table mapped PMD
+pmd_leaf                      Tests a leaf mapped PMD
+pmd_huge                      Tests a HugeTLB mapped PMD
+pmd_trans_huge                Tests a Transparent Huge Page (THP) at PMD
+pmd_present                   Tests a valid mapped PMD
+pmd_young                     Tests a young PMD
+pmd_dirty                     Tests a dirty PMD
+pmd_write                     Tests a writable PMD
+pmd_special                   Tests a special PMD
+pmd_protnone                  Tests a PROT_NONE PMD
+pmd_devmap                    Tests a ZONE_DEVICE mapped PMD
+pmd_soft_dirty                Tests a soft dirty PMD
+pmd_swp_soft_dirty            Tests a soft dirty swapped PMD
+pmd_mkyoung                   Creates a young PMD
+pmd_mkold                     Creates an old PMD
+pmd_mkdirty                   Creates a dirty PMD
+pmd_mkclean                   Creates a clean PMD
+pmd_mkwrite                   Creates a writable PMD
+pmd_mkwrprotect               Creates a write protected PMD
+pmd_mkspecial                 Creates a special PMD
+pmd_mkdevmap                  Creates a ZONE_DEVICE mapped PMD
+pmd_mksoft_dirty              Creates a soft dirty PMD
+pmd_clear_soft_dirty          Clears a soft dirty PMD
+pmd_swp_mksoft_dirty          Creates a soft dirty swapped PMD
+pmd_swp_clear_soft_dirty      Clears a soft dirty swapped PMD
+pmd_mkinvalid                 Invalidates a mapped PMD [1]
+pmd_set_huge                  Creates a PMD huge mapping
+pmd_clear_huge                Clears a PMD huge mapping
+pmdp_get_and_clear            Clears a PMD
+pmdp_get_and_clear_full       Clears a PMD
+pmdp_test_and_clear_young     Clears young from a PMD
+pmdp_set_wrprotect            Converts into a write protected PMD
+pmdp_set_access_flags         Converts into a more permissive PMD
+===========================   ================================================
 
 ======================
 PUD Page Table Helpers
 ======================
 
---------------------------------------------------------------------------------
-| pud_same                  | Tests whether both PUD entries are the same      |
---------------------------------------------------------------------------------
-| pud_bad                   | Tests a non-table mapped PUD                     |
---------------------------------------------------------------------------------
-| pud_leaf                  | Tests a leaf mapped PUD                          |
---------------------------------------------------------------------------------
-| pud_huge                  | Tests a HugeTLB mapped PUD                       |
---------------------------------------------------------------------------------
-| pud_trans_huge            | Tests a Transparent Huge Page (THP) at PUD       |
---------------------------------------------------------------------------------
-| pud_present               | Tests a valid mapped PUD                         |
---------------------------------------------------------------------------------
-| pud_young                 | Tests a young PUD                                |
---------------------------------------------------------------------------------
-| pud_dirty                 | Tests a dirty PUD                                |
---------------------------------------------------------------------------------
-| pud_write                 | Tests a writable PUD                             |
---------------------------------------------------------------------------------
-| pud_devmap                | Tests a ZONE_DEVICE mapped PUD                   |
---------------------------------------------------------------------------------
-| pud_mkyoung               | Creates a young PUD                              |
---------------------------------------------------------------------------------
-| pud_mkold                 | Creates an old PUD                               |
---------------------------------------------------------------------------------
-| pud_mkdirty               | Creates a dirty PUD                              |
---------------------------------------------------------------------------------
-| pud_mkclean               | Creates a clean PUD                              |
---------------------------------------------------------------------------------
-| pud_mkwrite               | Creates a writable PMD                           |
---------------------------------------------------------------------------------
-| pud_mkwrprotect           | Creates a write protected PMD                    |
---------------------------------------------------------------------------------
-| pud_mkdevmap              | Creates a ZONE_DEVICE mapped PMD                 |
---------------------------------------------------------------------------------
-| pud_mkinvalid             | Invalidates a mapped PUD [1]                     |
---------------------------------------------------------------------------------
-| pud_set_huge              | Creates a PUD huge mapping                       |
---------------------------------------------------------------------------------
-| pud_clear_huge            | Clears a PUD huge mapping                        |
---------------------------------------------------------------------------------
-| pudp_get_and_clear        | Clears a PUD                                     |
---------------------------------------------------------------------------------
-| pudp_get_and_clear_full   | Clears a PUD                                     |
---------------------------------------------------------------------------------
-| pudp_test_and_clear_young | Clears young from a PUD                          |
---------------------------------------------------------------------------------
-| pudp_set_wrprotect        | Converts into a write protected PUD              |
---------------------------------------------------------------------------------
-| pudp_set_access_flags     | Converts into a more permissive PUD              |
---------------------------------------------------------------------------------
+===========================   ================================================
+pud_same                      Tests whether both PUD entries are the same
+pud_bad                       Tests a non-table mapped PUD
+pud_leaf                      Tests a leaf mapped PUD
+pud_huge                      Tests a HugeTLB mapped PUD
+pud_trans_huge                Tests a Transparent Huge Page (THP) at PUD
+pud_present                   Tests a valid mapped PUD
+pud_young                     Tests a young PUD
+pud_dirty                     Tests a dirty PUD
+pud_write                     Tests a writable PUD
+pud_devmap                    Tests a ZONE_DEVICE mapped PUD
+pud_mkyoung                   Creates a young PUD
+pud_mkold                     Creates an old PUD
+pud_mkdirty                   Creates a dirty PUD
+pud_mkclean                   Creates a clean PUD
+pud_mkwrite                   Creates a writable PMD
+pud_mkwrprotect               Creates a write protected PMD
+pud_mkdevmap                  Creates a ZONE_DEVICE mapped PMD
+pud_mkinvalid                 Invalidates a mapped PUD [1]
+pud_set_huge                  Creates a PUD huge mapping
+pud_clear_huge                Clears a PUD huge mapping
+pudp_get_and_clear            Clears a PUD
+pudp_get_and_clear_full       Clears a PUD
+pudp_test_and_clear_young     Clears young from a PUD
+pudp_set_wrprotect            Converts into a write protected PUD
+pudp_set_access_flags         Converts into a more permissive PUD
+===========================   ================================================
 
 ==========================
 HugeTLB Page Table Helpers
 ==========================
 
---------------------------------------------------------------------------------
-| pte_huge                  | Tests a HugeTLB                                  |
---------------------------------------------------------------------------------
-| pte_mkhuge                | Creates a HugeTLB                                |
---------------------------------------------------------------------------------
-| huge_pte_dirty            | Tests a dirty HugeTLB                            |
---------------------------------------------------------------------------------
-| huge_pte_write            | Tests a writable HugeTLB                         |
---------------------------------------------------------------------------------
-| huge_pte_mkdirty          | Creates a dirty HugeTLB                          |
---------------------------------------------------------------------------------
-| huge_pte_mkwrite          | Creates a writable HugeTLB                       |
---------------------------------------------------------------------------------
-| huge_pte_mkwrprotect      | Creates a write protected HugeTLB                |
---------------------------------------------------------------------------------
-| huge_ptep_get_and_clear   | Clears a HugeTLB                                 |
---------------------------------------------------------------------------------
-| huge_ptep_set_wrprotect   | Converts into a write protected HugeTLB          |
---------------------------------------------------------------------------------
-| huge_ptep_set_access_flags  | Converts into a more permissive HugeTLB        |
---------------------------------------------------------------------------------
+============================   ===============================================
+pte_huge                       Tests a HugeTLB
+pte_mkhuge                     Creates a HugeTLB
+huge_pte_dirty                 Tests a dirty HugeTLB
+huge_pte_write                 Tests a writable HugeTLB
+huge_pte_mkdirty               Creates a dirty HugeTLB
+huge_pte_mkwrite               Creates a writable HugeTLB
+huge_pte_mkwrprotect           Creates a write protected HugeTLB
+huge_ptep_get_and_clear        Clears a HugeTLB
+huge_ptep_set_wrprotect        Converts into a write protected HugeTLB
+huge_ptep_set_access_flags     Converts into a more permissive HugeTLB
+============================   ===============================================
 
 ========================
 SWAP Page Table Helpers
 ========================
 
---------------------------------------------------------------------------------
-| __pte_to_swp_entry        | Creates a swapped entry (arch) from a mapepd PTE |
---------------------------------------------------------------------------------
-| __swp_to_pte_entry        | Creates a mapped PTE from a swapped entry (arch) |
---------------------------------------------------------------------------------
-| __pmd_to_swp_entry        | Creates a swapped entry (arch) from a mapepd PMD |
---------------------------------------------------------------------------------
-| __swp_to_pmd_entry        | Creates a mapped PMD from a swapped entry (arch) |
---------------------------------------------------------------------------------
-| is_migration_entry        | Tests a migration (read or write) swapped entry  |
---------------------------------------------------------------------------------
-| is_write_migration_entry  | Tests a write migration swapped entry            |
---------------------------------------------------------------------------------
-| make_migration_entry_read | Converts into read migration swapped entry       |
---------------------------------------------------------------------------------
-| make_migration_entry      | Creates a migration swapped entry (read or write)|
---------------------------------------------------------------------------------
+==========================  =================================================
+__pte_to_swp_entry          Creates a swapped entry (arch) from a mapepd PTE
+__swp_to_pte_entry          Creates a mapped PTE from a swapped entry (arch)
+__pmd_to_swp_entry          Creates a swapped entry (arch) from a mapepd PMD
+__swp_to_pmd_entry          Creates a mapped PMD from a swapped entry (arch)
+is_migration_entry          Tests a migration (read or write) swapped entry
+is_write_migration_entry    Tests a write migration swapped entry
+make_migration_entry_read   Converts into read migration swapped entry
+make_migration_entry        Creates a migration swapped entry (read or write)
+==========================  =================================================
 
 [1] https://lore.kernel.org/linux-mm/20181017020930.GN30832@redhat.com/

